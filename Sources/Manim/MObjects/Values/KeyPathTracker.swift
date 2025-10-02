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
    
    override init(_pythonObject: PythonObject) {
        fatalError()
    }
    
}


extension MObject {
    
    /// Returns a ``ValueTracker`` that is linked to `keyPath` of `self`.
    ///
    /// Even better, you can use ``MObject/track(_:)->ValueTracker`` that comes with syncing.
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
