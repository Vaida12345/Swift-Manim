//
//  Polygon.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


/// A shape consisting of one closed loop of vertices.
///
/// ```swift
/// let polygon = Polygon(vertices: [[1, 1], [2, 2], [1, 2]])
/// ```
///
/// ![Preview](Polygon)
public class Polygon: Polygram {
    
    /// Creates a shape.
    ///
    /// - Parameters:
    ///   - vertices: The dots among which will be connected.
    ///   - stroke: The color used for the shape's outline.
    ///   - strokeWidth: The width of the outline stroke, in points. The default stroke with is `4`.
    ///   - fill: The color used to fill the shape's interior.
    ///
    /// If `stroke` or `fill` are not specified, a default style will be applied with no `fill` and a ``Color/white`` `stroke`.
    public init(vertices: [Point], stroke: Color? = nil, _ strokeWidth: Double? = nil, fill: Color? = nil) {
        super.init("\(Self.self)", stroke: stroke, strokeWidth: strokeWidth, fill: fill) { arguments in
            arguments.insert("", vertices, at: 0)
        }
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
