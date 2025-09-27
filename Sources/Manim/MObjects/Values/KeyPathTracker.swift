//
//  KeyPathTracker.swift
//  Manim
//
//  Created by Vaida on 2025-09-24.
//

import PythonKit


final class KeyPathTracker: ValueTracker {
    
    let keyPath: ReferenceWritableKeyPath<MObject, Double>
    
    let base: MObject
    
    
    init(base: MObject, keyPath: ReferenceWritableKeyPath<MObject, Double>) {
        self.keyPath = keyPath
        self.base = base
        super.init(wrappedValue: base[keyPath: keyPath])
        
        base.addUpdater {
            base[keyPath: keyPath] = self.wrappedValue
        }
    }
    
    required init(_ pythonObject: PythonObject) {
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
    ///     x += 4
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/track.mov)
    ///
    /// - Parameters:
    ///   - keyPath: The key path of the property to be tracked.
    public func track(_ keyPath: ReferenceWritableKeyPath<MObject, Double>) -> ValueTracker {
        KeyPathTracker(base: self, keyPath: keyPath)
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
        _ keyPath: ReferenceWritableKeyPath<MObject, T>,
        to target: @autoclosure @escaping () -> T,
    ) where T: PythonConvertible & ConvertibleFromPython {
        self.addUpdater {
            self[keyPath: keyPath] = target()
        }
    }
    
    /// Binds `keyPath` to `object`.`onKeyPath`.
    @available(*, deprecated, renamed: "bind")
    public func link<T>(
        _ keyPath: ReferenceWritableKeyPath<MObject, T>,
        to target: @autoclosure @escaping () -> T,
    ) where T: PythonConvertible & ConvertibleFromPython {
        self.bind(keyPath, to: target())
    }
    
}
