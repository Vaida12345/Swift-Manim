//
//  ArcBetweenPoints.swift
//  Manim
//
//  Created by Vaida on 2025-09-24.
//

import SwiftUI
import PythonKit


/// Inherits from Arc and additionally takes 2 points between which the arc is spanned.
public class ArcBetweenPoints: TipableVMobject {
    
    /// Creates an arc.
    ///
    /// An animation of drawing arc would be generated.
    ///
    /// - Parameters:
    ///   - radius: The radius of arc.
    ///   - start: The start angle. When `start` is `0`, the line an arrow from (0, 0) to (1, 0)
    ///   - angle: The angle length.
    ///   - center: The center position.
    public init(radius: Double = 1, start: Angle = .zero, angle: Angle, center: Point = .center, color: Color = .yellow) {
        let object = manim.ArcBetweenPoints(radius: radius, start_angle: start.radians, angle: angle.radians, arc_center: center, color: color)
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
    public init(start: Point, end: Point, angle: Angle = .degrees(45), color: Color = .yellow) {
        let object = manim.ArcBetweenPoints(start: start, end: end, angle: angle.radians, color: color)
        super.init(object)
    }
    
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
