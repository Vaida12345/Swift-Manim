//
//  Show.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//


import SwiftUI


public struct ShowAnimation: Equatable {
    
    fileprivate let name: String
    
    fileprivate let args: Args
    
    
    fileprivate init(name: String, args: Args) {
        self.name = name
        self.args = args
    }
    
    /// No animation, just show the object.
    public static let none = ShowAnimation(name: "none", args: [])
    
    /// The default way of creation, by drawing the borders.
    ///
    /// - SeeAlso: ``ShowAnimation/drawBorderThenFill``
    public static let create = ShowAnimation(name: "Create", args: [])
    
    /// Draw the borders and fill by changing the opacity.
    public static let drawBorderThenFill = ShowAnimation(name: "DrawBorderThenFill", args: [])
    
    /// The style to texts, show text letter by letter.
    public static let addTextByLetter = ShowAnimation(name: "AddTextLetterByLetter", args: [])
    
    /// Show a ``VGroup`` with its children spiraled in. Applying this to a normal object would not work.
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
        ShowAnimation(name: "FadeIn", args: [("shift", shift?.pyDescription), ("scale", scale?.description)])
    }
    
    /// Grow the object form the given edge.
    ///
    /// The animation is a scaling from the given edge.
    public static func grow(from edge: Direction) -> ShowAnimation {
        ShowAnimation(name: "GrowFromEdge", args: [("edge", edge.pyDescription)])
    }
    
    /// Grow the object form the given point.
    ///
    /// The animation is a scaling from the given point.
    public static func grow(from point: Point) -> ShowAnimation {
        ShowAnimation(name: "GrowFromPoint", args: [(nil, point.pyDescription)])
    }
    
    /// Grow the object form the given object.
    ///
    /// The animation is a scaling from the given point.
    public static func grow(from object: MObject) -> ShowAnimation {
        ShowAnimation(name: "GrowFromPoint", args: [(nil, object.identifier)])
    }
    
    /// Grow the object form the given point.
    ///
    /// The animation is a scaling from the given point.
    public static func grow(from pointFunc: Method<Point>) -> ShowAnimation {
        ShowAnimation(name: "GrowFromPoint", args: [(nil, pointFunc.get())])
    }
    /// Scale and rotate.
    ///
    /// - Parameters:
    ///   - angle: The amount of spinning before object reaches its full size. E.g. 2*PI means that the object will do one full spin before being fully introduced.
    ///   - initialColor: the initial color of the point that grows into the object.
    public static func rotate(angle: Angle = .degrees(90), initialColor: Color? = nil) -> ShowAnimation {
        ShowAnimation(name: "SpinInFromNothing", args: [("angle", angle.radians.description), ("point_color", initialColor?.pyDescription)])
    }
    
    
    public static func == (lhs: ShowAnimation, rhs: ShowAnimation) -> Bool {
        lhs.name == rhs.name &&
        zip(lhs.args, rhs.args).allSatisfy { $0.key == $1.key && $0.value == $1.value }
    }
    
}


extension MObject {
    
    /// Show the object.
    @discardableResult
    public func show(animation: ShowAnimation = .create) -> Animation {
        if animation == .none || !shouldUseAnimation {
            Generator.main.add("self.add(\(self.identifier))")
            return EmptyAnimation()
        } else {
            return Animation(base: animation.name, args: [(nil, self.identifier)] + animation.args)
        }
        
    }
    
}
