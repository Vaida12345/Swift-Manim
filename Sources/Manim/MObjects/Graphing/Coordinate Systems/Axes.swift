//
//  Axes.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/17.
//

import PythonKit


/// Creates a set of axes.
///
/// The axes always span the entire screen.
///
/// ```swift
/// let axes = Axes()
/// ```
///
/// ![Preview](Axes)
///
/// - SeeAlso: ``NumberPlane``
public class Axes: Group {
    
    /// Creates a set of axes.
    ///
    /// Note that the axes coordinate space is the same as global coordinate space.
    ///
    /// - Parameters:
    ///   - domain: The `(x_min, x_max, x_step)` values of the x-axis.
    ///   - range: The `(y_min, y_max, y_step)` values of the y-axis.
    public init(domain: Range? = nil, range: Range? = nil) {
        let args: Closure.Arguments = [
            ("x_range", domain),
            ("y_range", range),
            ("x_length", manim.config.frame_width),
            ("y_length", manim.config.frame_height)
        ]
        
        super.init(manim.Axes.dynamicallyCall(withKeywordArguments: args))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
