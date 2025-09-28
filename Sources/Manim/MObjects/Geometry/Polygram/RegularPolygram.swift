//
//  RegularPolygram.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


/// A Polygram with regularly spaced vertices.
///
/// ```swift
/// let star = RegularPolygram(n: 5, density: 2)
/// ```
///
/// ![Preview](RegularPolygram)
public class RegularPolygram: Polygram {
    
    /// Creates a shape.
    ///
    /// - Parameters:
    ///   - n: The number of vertices.
    ///   - radius: The radius of the circle that the vertices are placed on.
    ///   - stroke: The color used for the shape's outline.
    ///   - strokeWidth: The width of the outline stroke, in points. The default stroke with is `4`.
    ///   - fill: The color used to fill the shape's interior.
    ///   - density: Can be thought of as how many vertices to hop to draw a line between them. Every `density`-th vertex is connected. See discussion for details.
    ///   - startAngle: The angle the vertices start at; the rotation of the ``RegularPolygram``.
    ///
    /// If `stroke` or `fill` are not specified, a default style will be applied with no `fill` and a ``Color/white`` `stroke`.
    ///
    /// ## density
    ///
    /// ![Preview](density)
    ///
    /// ```swift
    /// let objects = (1...5).map { density in
    ///     RegularPolygram(n: 5, density: density)
    /// }
    /// HStack(objects).show()
    ///
    /// for (i, object) in objects.enumerated() {
    ///     let text = Text("\(i + 1)")
    ///     text.move(above: object)
    ///     text.show()
    /// }
    /// ```
    public init(n: Int, radius: Double = 1, density: Int = 2, startAngle: Angle? = nil, stroke: Color? = nil, _ strokeWidth: Double? = nil, fill: Color? = nil) {
        super.init("\(Self.self)", stroke: stroke, strokeWidth: strokeWidth, fill: fill) { arguments in
            arguments.insert("num_vertices", n, at: 0)
            arguments.append("density", density)
            arguments.append("radius", radius)
            arguments.append("start_angle", startAngle?.radians)
        }
    }
    
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, defaultColor: Color = .white, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, defaultColor: defaultColor, builder)
    }
    
}
