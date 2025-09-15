//
//  ValueTracker.swift
//  Manim
//
//  Created by Vaida on 8/26/24.
//


/// A mobject that can be used for tracking (real-valued) parameters. Useful for animating parameter changes.
///
/// Not meant to be displayed. Instead the position encodes some number, often one which another animation or continual\_animation uses for its update function, and by treating it as a mobject it can still be animated and manipulated just like anything else.
public class ValueTracker<T>: MObject {
    
    public init(double: Double) where T == Double {
        super.init(base: "ValueTracker", args: [
            ("value", double.description)
        ])
    }
    
    public init(value: T) where T: PyObject {
        super.init(base: "ValueTracker", args: [
            ("value", value.identifier)
        ])
    }
    
    public init(value: Method<T>) {
        super.init(base: "ValueTracker", args: [
            ("value", value.get())
        ])
    }
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    public var value: Method<T> {
        Method(name: "get_value", args: [], parent: self)
    }
    
}


extension ValueTracker where T == Double {
    
    @discardableResult
    public func set(_ value: Double) -> AttachedAnimation {
        AttachedAnimation(
            name: "set_value",
            target: self.identifier,
            args: [
                (nil, value.description)
            ]
        )
    }
    
    @discardableResult
    public static func += (lhs: ValueTracker, rhs: Double) -> AttachedAnimation {
        AttachedAnimation(
            name: "increment_value",
            target: lhs.identifier,
            args: [
                (nil, rhs.description)
            ]
        )
    }
    
    @discardableResult
    public static func -= (lhs: ValueTracker, rhs: Double) -> AttachedAnimation {
        lhs += -rhs
    }
    
}
