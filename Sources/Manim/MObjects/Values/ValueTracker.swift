//
//  ValueTracker.swift
//  Manim
//
//  Created by Vaida on 8/26/24.
//

import PythonKit


/// A mobject that can be used for tracking (real-valued) parameters. Useful for animating parameter changes.
///
/// Not meant to be displayed. Instead the position encodes some number, often one which another animation or continual\_animation uses for its update function, and by treating it as a mobject it can still be animated and manipulated just like anything else.
///
/// You can use `tracker` to change any property of an object. For example, you can change the `x`-coordinate of a dot.
///
/// ```swift
/// let dot = Dot(color: .blue)
/// dot.show()
///
/// @ValueTracker
/// var x = 0.0
/// dot.addUpdater { dot.x = x }
///
/// withAnimation {
///     $x += 1
/// }
/// ```
///
/// Even better, you can use ``MObject/track(_:)->ValueTracker`` that comes with syncing.
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
///
/// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/track.mov)
@propertyWrapper
public class ValueTracker: Projection<Double> { // Python `ValueTracker` is always Double.
    
    /// The underlying value.
    public override var wrappedValue: Double {
        get { Double(self._pythonObject.get_value())! }
        set { self._pythonObject.set_value(newValue) }
    }
    
    /// Swift Syntax suger.
    ///
    /// Use `$wrappedValue` to access `self`.
    public override var projectedValue: ValueTracker {
        self
    }
    
    /// Creates a value tracker by providing an initial value.
    public init(wrappedValue value: Double) {
        let object = manim.ValueTracker(value)
        super.init(_pythonObject: object)
    }
    
    public required init(_pythonObject: PythonObject) {
        super.init(_pythonObject: _pythonObject)
    }
    
}

extension ValueTracker {
    
    /// Set the new value using an animation.
    @discardableResult
    public func become(_ value: Double) -> AttachedAnimation {
        AttachedAnimation(base: self._pythonObject, closure: Closure("set_value", [("", value)]))
    }
    
}


extension ValueTracker {
    
    @discardableResult
    public static func += (lhs: ValueTracker, rhs: Double) -> AttachedAnimation {
        lhs.become(lhs.wrappedValue + rhs)
    }
    
    @discardableResult
    public static func -= (lhs: ValueTracker, rhs: Double) -> AttachedAnimation {
        lhs += -rhs
    }
    
}
