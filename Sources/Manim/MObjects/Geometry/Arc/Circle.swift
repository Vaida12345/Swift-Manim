//
//  Circle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import PythonKit


/// A circle
public class Circle: Arc {
    
    
    /// - Parameters:
    ///   - color: The stroke color.
    ///   - radius: The radius of the circle.
    public init(radius: Double? = nil, color: Color = .yellow) {
        let object = manim.Circle(radius: radius, color: color)
        super.init(object)
    }
    
    /// Creates a shape.
    ///
    /// - Parameters:
    ///   - radius: The radius of the circle.
    ///   - stroke: The color used for the shape's outline.
    ///   - strokeWidth: The width of the outline stroke, in points. The default stroke with is `4`.
    ///   - fill: The color used to fill the shape's interior.
    ///
    /// If `stroke` or `fill` are not specified, a default style will be applied with no `stroke` and a `fill` color of ``Color/blue``.
    public convenience init(radius: Double = 1, stroke: Color? = nil, _ strokeWidth: Double? = nil, fill: Color? = nil) {
        self.init("Circle", stroke: stroke, strokeWidth: strokeWidth, fill: fill) { arguments in
            arguments.append("radius", radius)
        }
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
