//
//  Show.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import PythonKit


/// A builder for Manim-based reveal animations.
///
/// You can use ``MObject/show(animation:)`` to show an object, and pass a `ShowAnimation`.
@MainActor
public struct ShowAnimation {
    
    let caller: PythonObject
    
    let arguments: Closure.Arguments
    
    init(caller: PythonObject, arguments: Closure.Arguments = []) {
        self.caller = caller
        self.arguments = arguments
    }
    
    /// The default way of creation, by drawing the borders.
    ///
    /// - SeeAlso: ``ShowAnimation/drawBorderThenFill``
    public static let create = ShowAnimation(caller: manim.Create)
    
    /// Draw the borders and fill by changing the opacity.
    public static let drawBorderThenFill = ShowAnimation(caller: manim.DrawBorderThenFill)
    
    /// The style to texts, show text letter by letter.
    public static let addTextByLetter = ShowAnimation(caller: manim.AddTextLetterByLetter)
    
    /// Show a ``Group`` with its children spiraled in. Applying this to a normal object would not work.
    public static let spiralIn = ShowAnimation(caller: manim.SpiralIn)
    
    /// Write the text, by drawing the borders and then fill.
    public static let write = ShowAnimation(caller: manim.Write)
    
    /// Grows the arrow. Could only applied to arrows.
    public static let growArrow = ShowAnimation(caller: manim.GrowArrow)
    
    /// Grow the object from center.
    public static let growFromCenter = ShowAnimation(caller: manim.GrowFromCenter)
    
    
    /// Fade In.
    ///
    /// - Parameters:
    ///   - shift: Fade in with shift, with the direction being `shift`.
    ///   - scale: Fade in with scale. `scale` defines the initial scaling.
    public static func fadeIn(shift: Direction? = nil, scale: Double? = nil) -> ShowAnimation {
        ShowAnimation(caller: manim.FadeIn, arguments: [("shift", shift), ("scale", scale)])
    }
    
    /// Grow the object form the given object.
    ///
    /// The animation is a scaling from the given edge.
    public static func grow(from edge: Direction) -> ShowAnimation {
        ShowAnimation(caller: manim.GrowFromEdge, arguments: [("", edge)])
    }
    
    /// Grow the object form the given object.
    ///
    /// The animation is a scaling from the given point.
    public static func grow(from point: Point) -> ShowAnimation {
        ShowAnimation(caller: manim.GrowFromEdge, arguments: [("", point)])
    }
    
    /// Grow the object form the given object.
    ///
    /// The animation is a scaling from the given object.
    public static func grow(from object: MObject) -> ShowAnimation {
        ShowAnimation(caller: manim.GrowFromEdge, arguments: [("", object._pythonObject)])
    }
    
    /// Scale and rotate.
    ///
    /// - Parameters:
    ///   - angle: The amount of spinning before object reaches its full size. E.g. 2*PI means that the object will do one full spin before being fully introduced.
    ///   - initialColor: the initial color of the point that grows into the object.
    public static func rotate(angle: Angle = .degrees(90), initialColor: Color = .yellow) -> ShowAnimation {
        ShowAnimation(caller: manim.SpinInFromNothing, arguments: [("angle", angle.radians), ("point_color", initialColor)])
    }
}


extension MObject {
    
    /// Show the object.
    ///
    /// To animate the action, you must wrap it with ``withAnimation(_:in:body:)``.
    @discardableResult
    public func show(animation: ShowAnimation = .write) -> Animation {
        if !shouldUseAnimation {
            scene.add(self._pythonObject)
            return EmptyAnimation()
        } else {
            return WrappedAnimation(base: self._pythonObject, caller: animation.caller, arguments: animation.arguments)
        }
    }
    
}
