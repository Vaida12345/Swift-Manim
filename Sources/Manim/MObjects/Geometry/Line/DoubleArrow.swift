//
//  DoubleArrow.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


/// An arrow.
public final class DoubleArrow: Arrow {
    
    /// Creates the arrow
    ///
    /// - Parameters:
    ///   - start: The starting point of the arrow.
    ///   - end: The ending point of the arrow.
    ///   - padding: The distance of the arrow from its start and end points.
    ///   - strokeWidth: Stroke Width
    ///   - color: The stroke color.
    ///   - tip: The tip shape, `nil` for the default arrow shape.
    public override init(from start: Point, to end: Point, padding: Double = 0.25, strokeWidth: Double = 6, color: Color = .white, tip: Arrow.TipShape? = nil) {
        super.init(manim.Arrow(start: start, end: end, buff: padding, stroke_width: strokeWidth, color: color, tip_shape: tip))
    }
    
    /// Creates the arrow
    ///
    /// - Parameters:
    ///   - start: The starting point of the arrow.
    ///   - end: The ending point of the arrow.
    ///   - padding: The distance of the arrow from its start and end points.
    ///   - strokeWidth: Stroke Width
    ///   - color: The stroke color.
    ///   - startTip: The tip shape for `start`, `nil` for the default arrow shape.
    ///   - endTip: The tip shape for `end`, `nil` for the default arrow shape.
    public init(from start: Point, to end: Point, padding: Double = 0.25, strokeWidth: Double = 6, color: Color = .white, startTip: Arrow.TipShape? = nil, endTip: Arrow.TipShape? = nil) {
        super.init(manim.Arrow(start: start, end: end, buff: padding, stroke_width: strokeWidth, color: color, tip_shape_start: startTip, tip_shape_end: endTip))
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}

