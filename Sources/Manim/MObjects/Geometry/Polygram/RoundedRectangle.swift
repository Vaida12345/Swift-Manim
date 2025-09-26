//
//  RoundedRectangle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


public class RoundedRectangle: Rectangle {
    
    /// Creates a shape.
    ///
    /// - Parameters:
    ///   - height: The height of the rectangle
    ///   - width: The width of the rectangle
    ///   - cornerRadius: The corner radius of the rectangle
    ///   - stroke: The color used for the shape's outline.
    ///   - strokeWidth: The width of the outline stroke, in points. The default stroke with is `4`.
    ///   - fill: The color used to fill the shape's interior.
    ///
    /// If `stroke` or `fill` are not specified, a default style will be applied with no `stroke` and a `fill` color of ``Color/blue``.
    public convenience init(width: Double, height: Double, cornerRadius: Double = 0.5, stroke: Color? = nil, _ strokeWidth: Double? = nil, fill: Color? = nil) {
        self.init("\(Self.self)", stroke: stroke, strokeWidth: strokeWidth, fill: fill) { arguments in
            arguments.insert("width", width, at: 0)
            arguments.insert("height", height, at: 1)
            arguments.append("corner_radius", cornerRadius)
        }
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
