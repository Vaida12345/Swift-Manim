//
//  KeyPathTracker.swift
//  Manim
//
//  Created by Vaida on 2025-09-24.
//

import PythonKit


final class KeyPathTracker<T>: ValueTracker<T> where T: PythonConvertible & ConvertibleFromPython {
    
    let keyPath: ReferenceWritableKeyPath<MObject, T>
    
    let base: MObject
    
    
    init(base: MObject, keyPath: ReferenceWritableKeyPath<MObject, T>) {
        self.keyPath = keyPath
        self.base = base
        super.init(wrappedValue: base[keyPath: keyPath])
        
        base.addUpdater {
            base[keyPath: keyPath] = self.wrappedValue
        }
    }
    
    required public init(_ pythonObject: PythonObject) {
        fatalError()
    }
    
}


extension MObject {
    
    /// Returns a ``ValueTracker`` that is linked to `keyPath` of `self`.
    ///
    /// Even better, you can use ``MObject/track(_:)`` that comes with syncing.
    ///
    /// ```swift
    /// let dot = Dot(color: .blue)
    /// dot.show()
    ///
    /// let x = dot.track(\.x)
    /// withAnimation {
    ///     x += 1
    /// }
    /// ```
    public func track<T>(_ keyPath: ReferenceWritableKeyPath<MObject, T>) -> ValueTracker<T> where T: PythonConvertible & ConvertibleFromPython {
        KeyPathTracker(base: self, keyPath: keyPath)
    }
    
}


extension MObject {
    
    /// Binds `keyPath` to `object`.`onKeyPath`.
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
    public func bind<T>(
        _ keyPath: ReferenceWritableKeyPath<MObject, T>,
        to target: @autoclosure @escaping () -> T,
    ) where T: PythonConvertible & ConvertibleFromPython {
        self.addUpdater {
            self[keyPath: keyPath] = target()
        }
    }
    
    @available(*, deprecated, renamed: "bind")
    public func link<T>(
        _ keyPath: ReferenceWritableKeyPath<MObject, T>,
        to target: @autoclosure @escaping () -> T,
    ) where T: PythonConvertible & ConvertibleFromPython {
        self.bind(keyPath, to: target())
    }
    
}
