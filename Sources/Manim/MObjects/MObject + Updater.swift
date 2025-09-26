//
//  MObject + Updater.swift
//  Manim
//
//  Created by Vaida on 2025-09-25.
//

import Foundation
import PythonKit


extension MObject {
    
    /// Add an update function to *this* object.
    ///
    /// This function is designed to *update* self, not *observe* self. Hence it might be different from most `KVO` use-cases.
    ///
    /// ```swift
    /// let independent = Dot(color: .red)
    /// let dependent = Dot(color: .blue)
    ///
    /// scene.add(independent, dependent)
    ///
    /// let updater = dependent.addUpdater {
    ///     dependent.x = independent.x
    /// }
    ///
    /// withAnimation {
    ///     independent.move(to: [2, 2])
    /// } // dependent will also move to [2, 0]
    ///
    /// updater.removeFromParent()
    ///
    /// withAnimation {
    ///     independent.move(to: [-2, -2])
    /// } // dependent will remain at the same place
    /// ```
    ///
    /// ![preview](updater)
    ///
    /// - Parameters:
    ///   - index: The index at which the new updater should be added.
    ///   - initial: Whether the action should be run when this method is first called.
    ///   - handler: The update handler.
    @discardableResult
    public func addUpdater(index: Int? = nil, initial: Bool = false, handler: @escaping () -> Void) -> Updater {
        let uniqueName = "helper_\(UUID().uuidString.replacingOccurrences(of: "-", with: "_"))"
        let bridgeName = "_swift_bridge_\(UUID().uuidString.replacingOccurrences(of: "-", with: "_"))"
        
        let code = """
        def \(uniqueName)(obj):
            \(bridgeName)(obj)
        """
        
        let main = Python.import("__main__")
        main.__dict__[bridgeName] = PythonObject(PythonFunction({ object in
            handler()
            return Python.None
        }))
        Python.exec(code, main.__dict__)
        
        self.pythonObject.add_updater(main.__dict__[uniqueName], index: index, call_updater: initial)
        return Updater(origin: self.pythonObject, updater: main.__dict__[uniqueName])
    }
    
    /// Removes every updater.
    ///
    /// - Parameters:
    ///   - recursive: Whether to recursively remove all updaters for all children.
    public func removeAllUpdaters(recursive: Bool = true) {
        self.pythonObject.clear_updater(recursive: recursive)
    }
    
    /// Disable updating from updaters and animations.
    ///
    /// - Parameters:
    ///   - recursive: Whether to recursively suspend updating for all children.
    ///
    /// - SeeAlso: ``resume(recursive:)``
    public func pause(recursive: Bool = true) {
        self.pythonObject.suspend_updating(recursive: recursive)
    }
    
    /// Enable updating from updaters and animations.
    ///
    /// - Parameters:
    ///   - recursive: Whether to recursively suspend updating for all children.
    ///
    /// - SeeAlso: ``pause(recursive:)``
    public func resume(recursive: Bool = true) {
        self.pythonObject.resume_updating(recursive: recursive)
    }
    
    
    /// A controller for ``MObject`` updater.
    ///
    /// You can use ``MObject/addUpdater(index:initial:handler:)``
    @MainActor
    public struct Updater {
        
        let origin: PythonObject
        
        let updater: PythonObject
        
        
        /// Removes the updater from parent.
        public func removeFromParent() {
            origin.remove_updater(updater)
        }
        
    }
    
}
