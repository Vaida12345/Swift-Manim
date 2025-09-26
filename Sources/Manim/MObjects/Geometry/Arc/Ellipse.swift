//
//  Ellipse.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import PythonKit


/// An ellipse
///
/// ```swift
/// let ellipse = Ellipse(width: 4, height: 2)
/// ```
///
/// ![Preview](Ellipse)
public final class Ellipse: Circle {
    
    /// Creates a shape.
    ///
    /// - Parameters:
    ///   - width: The width of the ellipse.
    ///   - height: The height of the ellipse.
    ///   - stroke: The color used for the shape's outline.
    ///   - strokeWidth: The width of the outline stroke, in points. The default stroke with is `4`.
    ///   - fill: The color used to fill the shape's interior.
    ///
    /// If `stroke` or `fill` are not specified, a default style will be applied with no `fill` and a ``Color/white`` `stroke`.
    public convenience init(width: Double, height: Double, stroke: Color? = nil, _ strokeWidth: Double? = nil, fill: Color? = nil) {
        self.init("Ellipse", stroke: stroke, strokeWidth: strokeWidth, fill: fill) { arguments in
            arguments.append("width", width)
            arguments.append("height", height)
        }
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
