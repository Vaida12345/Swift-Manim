//
//  NumberPlane.swift
//  Manim
//
//  Created by Vaida on 8/26/24.
//

import PythonKit

/// Creates a number plane that spans the entire screen.
///
/// ```swift
/// let numberPlane = NumberPlane()
/// ```
///
/// ![example](NumberPlane)
///
/// - SeeAlso: ``Axes``
public class NumberPlane: Axes {
    
    /// Creates a set of axes.
    ///
    /// Note that the axes coordinate space is the same as global coordinate space.
    ///
    /// - Parameters:
    ///   - domain: The `(x_min, x_max, x_step)` values of the x-axis.
    ///   - range: The `(y_min, y_max, y_step)` values of the y-axis.
    ///   - margin: The margin outside the initial frame. Set a `margin` greater than `0` to move the camera around.
    public init(domain: Range? = nil, range: Range? = nil, margin: Double = 0) {
        let args: Closure.Arguments = [
            ("x_range", Range(domain?.min ?? -Double(manim.config.frame_width)!/2, domain?.max ?? Double(manim.config.frame_width)!/2)._expandBothSides(by: margin)),
            ("y_range", Range(range?.min ?? -Double(manim.config.frame_height)!/2, range?.max ?? Double(manim.config.frame_height)!/2)._expandBothSides(by: margin)),
            ("x_length", Double(manim.config.frame_width)! + margin * 2),
            ("y_length", Double(manim.config.frame_height)! + margin * 2)
        ]
        
        super.init(_pythonObject: manim.NumberPlane.dynamicallyCall(withKeywordArguments: args))
    }
    
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
