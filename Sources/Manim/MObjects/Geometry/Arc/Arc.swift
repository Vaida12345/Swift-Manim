//
//  Arc.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import Foundation
import PythonKit
import SwiftUI


/// A circular arc.
///
/// ```swift
/// let arc = Arc(angle: .degrees(180))
/// scene.add(arc)
/// ```
///
/// ![Preview](arc)
public class Arc: TipableVMObject {
    
    /// Creates an arc.
    ///
    /// - Parameters:
    ///   - radius: The radius of arc.
    ///   - startAngle: The start angle. When `start` is `0`, the line an arrow from (0, 0) to (1, 0)
    ///   - angle: The angle length.
    ///   - center: The center position.
    ///   - width: The stroke width.
    ///   - color: The stroke color.
    public init(radius: Double = 1, startAngle: Angle = .zero, angle: Angle, center: Point = .center, width: Double = 4, color: Color = .white) {
        let object = manim.Arc(radius: radius, start_angle: startAngle.radians, angle: angle.radians, arc_center: center, stroke_width: width, color: color)
        super.init(object)
    }
    
    /// Creates an arc.
    ///
    /// - Parameters:
    ///   - start: The starting point.
    ///   - end: The end point.
    ///   - angle: The degree of angle be between the central point to `start` and center to `end`.
    ///   - width: The stroke width.
    ///   - color: The stroke color.
    public init(start: Point, end: Point, angle: Angle = .degrees(45), width: Double = 4, color: Color = .white) {
        let object = manim.Arc(start: start, end: end, angle: angle.radians, stroke_width: width, color: color)
        super.init(object)
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
