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
    
    /// Creates a shape.
    ///
    /// - Parameters:
    ///   - n: The number of vertices.
    ///   - radius: The radius of the circle that the vertices are placed on.
    ///   - stroke: The color used for the shape's outline.
    ///   - strokeWidth: The width of the outline stroke, in points. The default stroke with is `4`.
    ///   - fill: The color used to fill the shape's interior.
    ///   - density: Can be thought of as how many vertices to hop to draw a line between them. Every `density`-th vertex is connected.
    ///   - startAngle: The angle the vertices start at; the rotation of the ``RegularPolygram``.
    ///
    /// If `stroke` or `fill` are not specified, a default style will be applied with no `fill` and a ``Color/white`` `stroke`.
    public convenience init(n: Int, radius: Double = 1, startAngle: Angle? = nil, stroke: Color? = nil, _ strokeWidth: Double? = nil, fill: Color? = nil, density: Int = 2) {
        self.init("\(Self.self)", stroke: stroke, strokeWidth: strokeWidth, fill: fill) { arguments in
            arguments.insert("num_vertices", n, at: 0)
            arguments.append("density", density)
            arguments.append("radius", radius)
            arguments.append("start_angle", startAngle?.radians)
        }
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
