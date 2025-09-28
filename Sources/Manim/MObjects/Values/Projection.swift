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
public class Projection<T>: MObject where T: PythonConvertible & ConvertibleFromPython {
    
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
    
    init(get: @escaping () -> T) {
        self.get = get
        
        super.init(manim.Mobject())
    }
    
    required init(_ pythonObject: PythonObject) {
        self.get = nil
        
        super.init(pythonObject)
    }
    
}


extension MObject {
    
    /// Returns a ``Projection`` of `keyPath`.
    public func track<T>(_ keyPath: KeyPath<MObject, T>) -> Projection<T> where T: PythonConvertible & ConvertibleFromPython {
        Projection {
            self[keyPath: keyPath]
        }
    }
    
}
