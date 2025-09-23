//
//  Show.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import MacroCollection
import SwiftUI


@MainActor
public struct ShowAnimation: @MainActor Equatable {
    
    fileprivate let closure: Closure
    
    
    fileprivate init(_ closure: Closure) {
        self.closure = closure
    }
    
    fileprivate init(name: String, args: Closure.Arguments) {
        self.closure = Closure(name, args)
    }
    
    /// The default way of creation, by drawing the borders.
    ///
    /// - SeeAlso: ``ShowAnimation/drawBorderThenFill``
    public static let create = ShowAnimation(name: "Create", args: [])
    
    /// Draw the borders and fill by changing the opacity.
    public static let drawBorderThenFill = ShowAnimation(name: "DrawBorderThenFill", args: [])
    
    /// The style to texts, show text letter by letter.
    public static let addTextByLetter = ShowAnimation(name: "AddTextLetterByLetter", args: [])
    
    /// Show a ``Group`` with its children spiraled in. Applying this to a normal object would not work.
    public static let spiralIn = ShowAnimation(name: "SpiralIn", args: [])
    
    /// Write the text, by drawing the borders and then fill.
    public static let write = ShowAnimation(name: "Write", args: [])
    
    /// Grows the arrow. Could only applied to arrows.
    public static let growArrow = ShowAnimation(name: "GrowArrow", args: [])
    
    /// Grow the object from center.
    public static let growFromCenter = ShowAnimation(name: "GrowFromCenter", args: [])
    
    
    /// Fade In.
    ///
    /// - Parameters:
    ///   - shift: Fade in with shift, with the direction being `shift`.
    ///   - scale: Fade in with scale. `scale` defines the initial scaling.
    public static func fadeIn(shift: Direction? = nil, scale: Double? = nil) -> ShowAnimation {
        ShowAnimation(name: "FadeIn", args: [("shift", shift?.representation), ("scale", scale?.description)])
    }
    
    /// Grow the object form the given edge.
    ///
    /// The animation is a scaling from the given edge.
    @varyArgumentType(Direction.self, variation: Point.self)
    @varyArgumentType(Direction.self, variation: MObject.self)
    @varyArgumentType(Direction.self, variation: ReadableProperty<Point>.self)
    public static func grow(from edge: Direction) -> ShowAnimation {
        ShowAnimation(name: "GrowFromEdge", args: [("edge", edge.representation)])
    }
    
    /// Scale and rotate.
    ///
    /// - Parameters:
    ///   - angle: The amount of spinning before object reaches its full size. E.g. 2*PI means that the object will do one full spin before being fully introduced.
    ///   - initialColor: the initial color of the point that grows into the object.
    public static func rotate(angle: Angle = .degrees(90), initialColor: Color? = nil) -> ShowAnimation {
        ShowAnimation(name: "SpinInFromNothing", args: [("angle", angle.radians.description), ("point_color", initialColor?.representation)])
    }
}


extension MObject {
    
    /// Show the object.
    ///
    /// To animate the action, you must wrap it with ``withAnimation(_:in:body:)``.
    ///
    /// - Important: Starting from `v0.2`, you must call this method to show an object before using it.
    @discardableResult
    public func show(animation: ShowAnimation = .create) -> Animation {
        if !shouldUseAnimation {
            Generator.main.add("self.add(\(self.identifier))")
            return EmptyAnimation()
        } else {
            return Animation(animation.closure.name, arguments: [(nil, self.identifier)] + (animation.closure.arguments ?? []))
        }
    }
    
}
