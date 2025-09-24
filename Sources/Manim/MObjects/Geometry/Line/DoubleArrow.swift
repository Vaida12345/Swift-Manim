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
    ///   - tip: The tip shape, `nil` for the default arrow shape.
    public override init(from start: Point, to end: Point, padding: Double = 0.25, strokeWidth: Double = 6, color: Color = .white, tip: ArrowTipShape? = nil) {
        super.init(manim.Arrow(start: start, end: end, buff: padding, stroke_width: strokeWidth, color: color, tip_shape: tip))
    }
    
    public init(from start: Point, to end: Point, padding: Double = 0.25, strokeWidth: Double = 6, color: Color = .white, startTip: ArrowTipShape? = nil, endTip: ArrowTipShape? = nil) {
        super.init(manim.Arrow(start: start, end: end, buff: padding, stroke_width: strokeWidth, color: color, tip_shape_start: startTip, tip_shape_end: endTip))
    }
    
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}

