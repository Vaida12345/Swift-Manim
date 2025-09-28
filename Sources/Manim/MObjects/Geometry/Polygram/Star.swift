//
//  Star.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


/// A regular polygram without the intersecting lines.
///
/// ```swift
/// let star = Star()
/// ```
///
/// ![Preview](Star)
///
/// To draw a star with crossings, see ``RegularPolygram``.
public final class Star: Polygram {
    
    /// Creates a shape.
    ///
    /// - Parameters:
    ///   - n: How many points on the Star.
    ///   - innerRadius: The radius of the circle that the inner vertices are placed on.
    ///   - outerRadius: The radius of the circle that the outer vertices are placed on.
    ///   - startAngle: The start angle. When `start` is `0`, the line an arrow from (0, 0) to (1, 0)
    ///   - stroke: The color used for the shape's outline.
    ///   - strokeWidth: The width of the outline stroke, in points. The default stroke with is `4`.
    ///   - fill: The color used to fill the shape's interior.
    ///
    /// If `stroke` or `fill` are not specified, a default style will be applied with no `fill` and a ``Color/white`` `stroke`.
    public init(n: Int = 5, innerRadius: Double? = nil, outerRadius: Double = 1, startAngle: Angle = .radians(1.5707963267948966), stroke: Color? = nil, _ strokeWidth: Double? = nil, fill: Color? = nil) {
        super.init("\(Self.self)", stroke: stroke, strokeWidth: strokeWidth, fill: fill) { arguments in
            arguments.insert("n", n, at: 0)
            arguments.append("inner_radius", innerRadius)
            arguments.append("outer_radius", outerRadius)
            arguments.append("start_angle", startAngle.radians)
        }
    }
    
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, defaultColor: Color = .white, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, defaultColor: defaultColor, builder)
    }
    
}
