//
//  RegularPolygram.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit
import SwiftUI


/// A Polygram with regularly spaced vertices.
public class RegularPolygram: Polygram {
    
    /// Creates a ``RegularPolygram``.
    ///
    /// - Parameters:
    ///   - n: The number of vertices.
    ///   - density: Can be thought of as how many vertices to hop to draw a line between them. Every `density`-th vertex is connected.
    ///   - radius: The radius of the circle that the vertices are placed on.
    ///   - startAngle: The angle the vertices start at; the rotation of the ``RegularPolygram``.
    public init(n: Int, density: Int = 2, radius: Double = 1, startAngle: Angle? = nil, color: Color) {
        super.init(manim.RegularPolygram(num_vertices: n, density: density, radius: radius, start_angle: startAngle?.radians, color: color))
    }
    
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
