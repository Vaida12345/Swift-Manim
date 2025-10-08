//
//  MObject + Updater.swift
//  Manim
//
//  Created by Vaida on 2025-09-25.
//

import Foundation
import PythonKit


/// A controller for ``MObject`` updater.
///
/// You can use ``MObject/addUpdater(index:initial:handler:)`` to obtain an updater.
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
/// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/updater.mov)
@MainActor
public struct Updater {
    
    let origin: PythonObject
    
    let updater: PythonObject
    
    
    /// Removes the updater from parent.
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
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/updater.mov)
    public func removeFromParent() {
        origin.remove_updater(updater)
    }
    
}


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
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/updater.mov)
    ///
    /// - Parameters:
    ///   - index: The index at which the new updater should be added.
    ///   - initial: Whether the action should be run when this method is first called.
    ///   - handler: The update handler.
    ///
    /// - term dt: The time in seconds since the last update call.
    @discardableResult
    public func addUpdater(index: Int? = nil, initial: Bool = false, handler: @escaping (_ dt: Double) -> Void) -> Updater {
        let uniqueName = "helper_\(UUID().uuidString.replacingOccurrences(of: "-", with: "_"))"
        let bridgeName = "_swift_bridge_\(UUID().uuidString.replacingOccurrences(of: "-", with: "_"))"
        
        let code = """
        def \(uniqueName)(obj, dt):
            \(bridgeName)(obj, dt)
        """
        
        let main = Python.import("__main__")
        main.__dict__[bridgeName] = PythonObject(PythonFunction({ objects in
            handler(Double(objects[1])!)
            return Python.None
        }))
        Python.exec(code, main.__dict__)
        
        self._pythonObject.add_updater(main.__dict__[uniqueName], index: index, call_updater: initial)
        return Updater(origin: self._pythonObject, updater: main.__dict__[uniqueName])
    }
    
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
    ///     $0.x = independent.x
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
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/updater.mov)
    ///
    /// - Parameters:
    ///   - index: The index at which the new updater should be added.
    ///   - initial: Whether the action should be run when this method is first called.
    ///   - handler: The update handler.
    @discardableResult
    public func addUpdater(index: Int? = nil, initial: Bool = false, handler: @escaping () -> Void) -> Updater {
        self.addUpdater(index: index, initial: initial) { dt in
            handler()
        }
    }
    
    /// Removes every updater.
    ///
    /// - Parameters:
    ///   - recursive: Whether to recursively remove all updaters for all children.
    public func removeAllUpdaters(recursive: Bool = true) {
        self._pythonObject.clear_updaters(recursive: recursive)
    }
    
    /// Disable updating from updaters and animations.
    ///
    /// - Parameters:
    ///   - recursive: Whether to recursively suspend updating for all children.
    ///
    /// - SeeAlso: ``resume(recursive:)``
    public func pause(recursive: Bool = true) {
        self._pythonObject.suspend_updating(recursive: recursive)
    }
    
    /// Enable updating from updaters and animations.
    ///
    /// - Parameters:
    ///   - recursive: Whether to recursively suspend updating for all children.
    ///
    /// - SeeAlso: ``pause(recursive:)``
    public func resume(recursive: Bool = true) {
        self._pythonObject.resume_updating(recursive: recursive)
    }
}


extension MObject {
    
    func addUpdater(_ closure: @autoclosure @escaping () -> AttachedAnimation) -> AttachedAnimation {
        self.addUpdater { _ in let _ = closure() } // ignores the returned animation.
        return closure()
    }
    
}


extension MObject {
    
    /// Binds `keyPath` to `target`.
    ///
    /// You can use `bind` to ensure two properties are always in sync.
    ///
    /// ```swift
    /// let dot1 = Dot(at: [0, 2], color: .blue)
    /// let dot2 = Dot(at: .center, color: .green)
    ///
    /// scene.add(dot1, dot2)
    ///
    /// dot1.bind(\.x, to: dot2.x)
    ///
    /// withAnimation {
    ///     dot2.move(to: [2, 0])
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/bind.mov)
    ///
    /// - Parameters:
    ///   - keyPath: The key path of the property to be bind to `target`.
    ///   - target: The target property.
    public func bind<T>(
        _ keyPath: ReferenceWritableKeyPath<Self, T>,
        to target: @autoclosure @escaping () -> T,
    ) where T: PythonConvertible & ConvertibleFromPython {
        self.addUpdater {
            self[keyPath: keyPath] = target()
        }
    }
    
    /// Binds `keyPath` to `object`.`onKeyPath`.
    @available(*, deprecated, renamed: "bind")
    public func link<T>(
        _ keyPath: ReferenceWritableKeyPath<Self, T>,
        to target: @autoclosure @escaping () -> T,
    ) where T: PythonConvertible & ConvertibleFromPython {
        self.bind(keyPath, to: target())
    }
    
}
