//
//  Rectangle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import PythonKit


/// A quadrilateral with two sets of parallel sides.
///
/// ```swift
/// let rect = Rectangle(width: 4, height: 2)
/// ```
///
/// ![Preview](Rectangle)
public class Rectangle: Polygon {
    
    /// Creates a rectangle.
    ///
    /// - Parameters:
    ///   - width: The width of the rectangle
    ///   - height: The height of the rectangle
    ///   - stroke: The color used for the shape's outline.
    ///   - strokeWidth: The width of the outline stroke, in points. The default stroke with is `4`.
    ///   - fill: The color used to fill the shape's interior.
    ///
    /// If `stroke` or `fill` are not specified, a default style will be applied with no `fill` and a ``Color/white`` `stroke`.
    public init(width: Double, height: Double, stroke: Color? = nil, _ strokeWidth: Double? = nil, fill: Color? = nil) {
        super.init("\(Self.self)", stroke: stroke, strokeWidth: strokeWidth, fill: fill) { arguments in
            arguments.insert("width", width, at: 0)
            arguments.insert("height", height, at: 1)
        }
    }
    
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
