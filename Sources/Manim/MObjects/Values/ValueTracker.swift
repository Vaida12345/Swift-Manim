//
//  ValueTracker.swift
//  Manim
//
//  Created by Vaida on 8/26/24.
//


/// A mobject that can be used for tracking (real-valued) parameters. Useful for animating parameter changes.
///
/// Not meant to be displayed. Instead the position encodes some number, often one which another animation or continual\_animation uses for its update function, and by treating it as a mobject it can still be animated and manipulated just like anything else.
public class ValueTracker: MObject {
    
    public init(value: Double = 0) {
        super.init(args: [
            ("value", value.description)
        ])
    }
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
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
