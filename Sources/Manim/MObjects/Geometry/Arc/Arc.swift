//
//  Arc.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import Foundation
import PythonKit
import SwiftUI


/// A circle
public class Arc: VMObject {
    
    /// Creates an arc.
    ///
    /// An animation of drawing arc would be generated.
    ///
    /// - Parameters:
    ///   - radius: The radius of arc.
    ///   - start: The start angle. When `start` is `0`, the line an arrow from (0, 0) to (1, 0)
    ///   - angle: The angle length.
    ///   - center: The center position.
    public init(radius: Double = 1, start: Angle = .zero, angle: Angle, center: Point = .center) {
        let object = manim.Arc(radius: radius, start_angle: start.radians, angle: angle.radians, arc_center: center)
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
    public init(start: Point, end: Point, angle: Angle = .degrees(45)) {
        let object = manim.Arc(start: start, end: end, angle: angle.radians)
        super.init(object)
    }
    
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
