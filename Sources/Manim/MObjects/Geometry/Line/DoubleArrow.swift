//
//  DoubleArrow.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


/// An arrow.
///
/// ```swift
/// let arrow = DoubleArrow(from: [-1, -1], to: [1, 1])
/// ```
///
/// ![Preview](DoubleArrow)
public final class DoubleArrow: Arrow {
    
    /// Creates an arrow.
    ///
    /// - Parameters:
    ///   - start: The starting point of the arrow.
    ///   - end: The ending point of the arrow.
    ///   - width: The stroke width.
    ///   - color: The stroke color.
    ///   - padding: The paddings between the line and `start`, `end`.
    ///   - tip: The tip shape
    public override init(from start: Point, to end: Point, width: Double = 4, color: Color = .white, padding: Double = 0, tip: Arrow.TipShape = .triangleFilled) {
        super.init(manim.DoubleArrow(start: start, end: end, stroke_width: width, color: color, buff: padding, tip_shape: tip))
    }
    
    /// Creates an arrow.
    ///
    /// - Parameters:
    ///   - start: The starting point of the arrow.
    ///   - end: The ending point of the arrow.
    ///   - width: The stroke width.
    ///   - color: The stroke color.
    ///   - padding: The paddings between the line and `start`, `end`.
    ///   - startTip: The tip shape for `start`.
    ///   - endTip: The tip shape for `end`.
    public init(from start: Point, to end: Point, width: Double = 4, color: Color = .white, padding: Double = 0, startTip: Arrow.TipShape = .triangleFilled, endTip: Arrow.TipShape = .triangleFilled) {
        super.init(manim.DoubleArrow(start: start, end: end, stroke_width: width, color: color, buff: padding, tip_shape_start: startTip, tip_shape_end: endTip))
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}

