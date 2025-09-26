//
//  Square.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import PythonKit


/// A square.
///
/// ```swift
/// let square = Square(length: 2)
/// ```
///
/// ![Preview](Square)
public final class Square: Rectangle {
    
    /// Creates a shape.
    ///
    /// - Parameters:
    ///   - length: The length for each side.
    ///   - stroke: The color used for the shape's outline.
    ///   - strokeWidth: The width of the outline stroke, in points. The default stroke with is `4`.
    ///   - fill: The color used to fill the shape's interior.
    ///
    /// If `stroke` or `fill` are not specified, a default style will be applied with no `fill` and a ``Color/white`` `stroke`.
    public init(length: Double, stroke: Color? = nil, _ strokeWidth: Double? = nil, fill: Color? = nil) {
        super.init("\(Self.self)", stroke: stroke, strokeWidth: strokeWidth, fill: fill) { arguments in
            arguments.insert("side_length", length, at: 0)
        }
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
