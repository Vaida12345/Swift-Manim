//
//  Arc.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import Foundation
import PythonKit
import SwiftUI


/// An Arc
public class Arc: TipableVMObject {
    
    /// Creates an arc.
    ///
    /// An animation of drawing arc would be generated.
    ///
    /// - Parameters:
    ///   - radius: The radius of arc.
    ///   - startAngle: The start angle. When `start` is `0`, the line an arrow from (0, 0) to (1, 0)
    ///   - angle: The angle length.
    ///   - center: The center position.
    ///   - color: The stroke color.
    public init(radius: Double = 1, startAngle: Angle = .zero, angle: Angle, center: Point = .center, color: Color = .yellow) {
        let object = manim.Arc(radius: radius, start_angle: startAngle.radians, angle: angle.radians, arc_center: center, color: color)
        super.init(object)
    }
    
    /// Creates an arc.
    ///
    /// An animation of drawing arc would be generated.
    ///
    /// - Parameters:
    ///   - start: The starting point.
    ///   - end: The end point.
    ///   - angle: The degree of angle be between the central point to `start` and center to `end`.
    ///   - color: The stroke color.
    public init(start: Point, end: Point, angle: Angle = .degrees(45), color: Color = .yellow) {
        let object = manim.Arc(start: start, end: end, angle: angle.radians, color: color)
        super.init(object)
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
