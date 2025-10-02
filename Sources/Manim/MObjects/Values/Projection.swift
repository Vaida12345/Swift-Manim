//
//  ValueTracker.swift
//  Manim
//
//  Created by Vaida on 8/26/24.
//

import PythonKit


/// A projection to a ``ValueTracker``.
///
/// Different to ``ValueTracker``, `Projection`s are read-only, and changes when the property that created the projection changes.
///
/// You can use ``MObject/track(_:)->Projection<T>`` that comes with syncing.
@propertyWrapper
@dynamicMemberLookup
@MainActor
public class Projection<T>: @MainActor MObject where T: PythonConvertible & ConvertibleFromPython {
    
    public var _pythonObject: PythonKit.PythonObject
    
    
    let get: (() -> T)! // optional for `ValueTracker` to inherit from `Binding`.
    
    /// The underlying value.
    public var wrappedValue: T {
        self.get()
    }
    
    /// Swift Syntax suger.
    ///
    /// Use `$wrappedValue` to access `self`.
    public var projectedValue: Projection<T> {
        self
    }
    
    subscript<Subject>(dynamicMember keyPath: KeyPath<T, Subject>) -> Projection<Subject> {
        Projection<Subject> {
            self.wrappedValue[keyPath: keyPath]
        }
    }
    
    init(_pythonObject: PythonObject) {
        self.get = nil
        self._pythonObject = _pythonObject
    }
    
    /// Creates a projection using the `get` closure.
    ///
    /// - Parameters:
    ///   - get: On access, the ``wrappedValue`` will be evaluated using the provided closure.
    public init(get: @escaping () -> T) {
        self.get = get
        self._pythonObject = manim.Mobject()
    }
}


extension MObject {
    
    /// Returns a ``Projection`` of `keyPath`.
    public func track<T>(_ keyPath: KeyPath<Self, T>) -> Projection<T> where T: PythonConvertible & ConvertibleFromPython {
        Projection {
            self[keyPath: keyPath]
        }
    }
    
}
