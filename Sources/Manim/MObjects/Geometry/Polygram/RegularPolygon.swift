//
//  RegularPolygon.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


/// An n-sided regular Polygon.
///
/// ```swift
/// let hex = RegularPolygon(n: 6)
/// ```
///
/// ![Preview](RegularPolygon)
public class RegularPolygon: RegularPolygram {
    
    /// Creates a shape.
    ///
    /// - Parameters:
    ///   - n: The number of sides of the RegularPolygon.
    ///   - stroke: The color used for the shape's outline.
    ///   - strokeWidth: The width of the outline stroke, in points. The default stroke with is `4`.
    ///   - fill: The color used to fill the shape's interior.
    ///
    /// If `stroke` or `fill` are not specified, a default style will be applied with no `fill` and a ``Color/white`` `stroke`.
    public init(n: Int, stroke: Color? = nil, _ strokeWidth: Double? = nil, fill: Color? = nil) {
        super.init("\(Self.self)", stroke: stroke, strokeWidth: strokeWidth, fill: fill) { arguments in
            arguments.insert("", n, at: 0)
        }
    }
    
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
