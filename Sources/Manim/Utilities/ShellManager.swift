//
//  ShellManager.swift
//  The Support Module
//
//  Created by Vaida on 4/13/22.
//  Copyright © 2019 - 2023 Vaida. All rights reserved.
//


#if os(macOS)
import Foundation
import os


/// A convenient interface to run shell.
///
/// - Important: One `ShellManager` can only deal with one task at a time.
///
/// **Initialization**
///
/// There are several ways to create a manager.
///
/// ```swift
/// // You use this manager by first initializing it.
/// let shellManager = ShellManager()
///
/// // Then, ask the manager to run a task by
/// shellManager.run(path: "folder/executable", arguments: "ls")
///
/// // If you want you use the default shell (`/bin/zsh`), you can run this by
/// shellManager.run(arguments: "ls")
///
/// // Or simply
/// shellManager("ls")
/// ```
///
/// **Getting results**
///
/// The ways of waiting for result.
///
/// ```swift
/// // You can obtain the result by
/// await shellManager.output()!
///
/// // Or, if you are not interested in the output
/// await shellManager.wait()
/// ```
@dynamicMemberLookup
public final class ShellManager: Equatable, Hashable, Identifiable {
    
    /// The object that represents a subprocess of the current process.
    private var task: Process
    
    /// The one-way communications channel between related processes.
    private let pipe: Pipe
    
    /// Returns a boolean value indicating whether the task is running.
    public var isRunning: Bool {
        task.isRunning
    }
    
    /// Initialize a shell Manager.
    public init() {
        self.task = Process()
        self.pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = pipe
    }
    
    deinit {
        pipe.fileHandleForReading.readabilityHandler = nil
        task.terminationHandler = nil
    }
    
    /// Creates and runs a task with a specified executable and arguments.
    ///
    /// If it runs successfully, it would return `true`, otherwise `false`.
    @discardableResult
    public func run(item: String? = nil, arguments: String) -> Bool {
        let logger = Logger(subsystem: "The Support Framework", category: "ShellManager")
        
        if let item = item {
            logger.info("Started Terminal Command: \n\(item) \(arguments, privacy: .public)")
            self.task.launchPath = item
            self.task.arguments = [arguments]
            do {
                try self.task.run()
            } catch {
                return false
            }
            return true
        } else {
            logger.info("Started Terminal Command: \n\(arguments, privacy: .public)")
            self.task.launchPath = "/bin/zsh"
            self.task.arguments = ["-c", arguments]
            do {
                try self.task.run()
            } catch {
                return false
            }
            return true
        }
    }
    
    /// Reads results from the `Process`.
    public func output() async -> String? {
        if #available(macOS 10.15.4, *) {
            guard let data = try? pipe.fileHandleForReading.readToEnd() else { return nil }
            return String(data: data, encoding: .utf8)
        } else {
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            return String(data: data, encoding: .utf8)
        }
    }
    
    /// Reads results from the `Process`.
    public func output() -> String? {
        if #available(macOS 10.15.4, *) {
            guard let data = try? pipe.fileHandleForReading.readToEnd() else { return nil }
            return String(data: data, encoding: .utf8)
        } else {
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            return String(data: data, encoding: .utf8)
        }
    }
    
    /// A hander which calls whenever a new line is generated.
    ///
    /// - Important: Using this method would cause ``output()-44p1x`` returning only partial results.
    ///
    /// - Experiment: When the `task` ``output()-44p1x`` is generated fast, the last few results may be ignored.
    ///
    /// - Bug: Reading from python `print` would wait until all output are generated.
    ///
    /// - parameters:
    ///   - handler: The handler whose parameter is a newline generated.
    public func onOutputChanged(_ handler: @escaping (_ newLine: String) -> Void) {
        
        var cache: String = ""
        
        func hander(newString: String) {
            cache += newString
            
            let components = cache.components(separatedBy: .newlines)
            cache = components.last ?? ""
            
            guard components.count != 1 else { return }
            
            for component in components.dropLast() {
                guard !component.isEmpty else { continue }
                handler(component)
            }
        }
        
        pipe.fileHandleForReading.readabilityHandler = { provider in
            let data = provider.availableData
            guard !data.isEmpty else { return }
            guard let value = String(data: data, encoding: .utf8) else { return }
            hander(newString: value)
        }
    }
    
    /// Wait until exit.
    ///
    /// Blocks the process until the receiver is finished.
    ///
    /// = Returns: The termination status, `0` for success.
    @discardableResult
    public func wait() -> Int32 {
        task.waitUntilExit()
        pipe.fileHandleForReading.readabilityHandler = nil
        return task.terminationStatus
    }
    
    /// Suspends execution of the receiver task.
    ///
    /// Multiple ``pause()`` messages can be sent, but they must be balanced with an equal number of ``resume()`` messages before the task resumes execution.
    public func pause() {
        task.suspend()
    }
    
    /// Resumes execution of a suspended task.
    ///
    /// Multiple ``pause()`` messages can be sent, but they must be balanced with an equal number of ``resume()`` messages before the task resumes execution.
    public func resume() {
        task.resume()
    }
    
    /// Sends a terminate signal to the receiver and all of its subtasks.
    public func terminate() {
        task.terminate()
        pipe.fileHandleForReading.readabilityHandler = nil
    }
    
    /// A completion block the system invokes when the task completes.
    public func onTermination(handler: @escaping (Process) -> Void) {
        task.terminationHandler = handler
    }
    
    /// Creates the hash value.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
        hasher.combine(self.task)
        hasher.combine(self.pipe)
    }
    
    /// Compares two managers.
    public static func == (lhs: ShellManager, rhs: ShellManager) -> Bool {
        lhs.task == rhs.task && lhs.pipe == rhs.pipe && lhs.id == rhs.id
    }
    
    /// The implementation of dynamic callable.
    public subscript<Subject>(dynamicMember keyPath: WritableKeyPath<Process, Subject>) -> Subject {
        get { self.task[keyPath: keyPath] }
        set { self.task[keyPath: keyPath] = newValue }
    }
    
    /// The implementation of dynamic callable.
    public subscript<Subject>(dynamicMember keyPath: KeyPath<Process, Subject>) -> Subject {
        self.task[keyPath: keyPath]
    }
    
}


/// A manager to manage a set of `ShellManager`s.
public final class ShellManagers: Hashable, Identifiable {
    
    /// The contained managers.
    private var contents: [ShellManager]
    
    /// Creates an empty manager.
    public init() {
        self.contents = []
    }
    
    /// Adds a new manager.
    public func addManager() -> ShellManager {
        let newManager = ShellManager()
        newManager.onTermination { [weak self, weak newManager] _ in
            if self != nil && self!.contents.count > 0 { // remove the element only if it has not been released.
                self!.contents.removeAll { $0 == newManager }
            }
        }
        self.contents.append(newManager)
        return newManager
    }
    
    /// Terminates and removes a manager.
    public func remove(manager: ShellManager) {
        manager.terminate()
        self.contents.removeAll { $0 == manager }
    }
    
    /// Resumes execution of all tasks.
    ///
    /// Multiple ``pause()`` messages can be sent, but they must be balanced with an equal number of ``resume()`` messages before the task resumes execution.
    public func resume() {
        for i in contents {
            i.resume()
        }
    }
    
    /// Sends a terminate signal to the all the receivers and all of their subtasks.
    public func terminate() {
        for i in contents {
            i.terminate()
        }
    }
    
    /// Sends a terminate signal to the all the running receivers and all of their subtasks.
    public func terminateIfPosible() {
        for i in contents {
            guard i.isRunning else { continue }
            i.terminate()
        }
    }
    
    /// Suspends execution of all the tasks.
    ///
    /// Multiple ``pause()`` messages can be sent, but they must be balanced with an equal number of ``resume()`` messages before the task resumes execution.
    public func pause() {
        for i in contents {
            i.pause()
        }
    }
    
    /// Creates a hash value.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(contents)
    }
    
    /// Compare two sets of managers.
    public static func == (lhs: ShellManagers, rhs: ShellManagers) -> Bool {
        lhs.contents == rhs.contents
    }
    
}
#endif
