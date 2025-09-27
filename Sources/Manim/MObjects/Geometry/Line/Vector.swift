//
//  Vector.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


/// A Arrow, with the `start` being `.zero`.
///
/// ```swift
/// let vector = Vector([1, 1])
/// ```
///
/// ![Preview](Vector)
public final class Vector: Arrow {
    
    /// Creates a vector.
    ///
    /// - Parameters:
    ///   - direction: The direction of the arrow.
    ///   - width: The stroke width.
    ///   - color: The stroke color.
    ///   - padding: The paddings between the line and `start`, `end`.
    ///   - tip: The tip shape
    public init(_ direction: Point, width: Double = 4, color: Color = .white, padding: Double = 0, tip: Arrow.TipShape = .triangleFilled) {
        super.init(manim.Vector(direction: direction, stroke_width: width, color: color, buff: padding, tip_shape: tip))
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
