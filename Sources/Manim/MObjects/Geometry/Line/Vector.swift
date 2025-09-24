//
//  Vector.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


/// A Arrow, with the `start` being `.zero`.
public final class Vector: Arrow {
    
    /// - Parameters:
    ///   - direction: The direction of the arrow.
    ///   - padding: The distance of the vector from its endpoints.
    ///   - strokeWidth: Stroke Width
    ///   - color: The stroke color.
    ///   - tip: The tip shape, `nil` for the default arrow shape.
    public init(_ direction: Point, padding: Double = 0, strokeWidth: Double = 6, color: Color = .white, tip: ArrowTipShape? = nil) {
        super.init(manim.Vector(direction: direction, color: color, buff: padding, stroke_width: strokeWidth, tip_shape: tip))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
