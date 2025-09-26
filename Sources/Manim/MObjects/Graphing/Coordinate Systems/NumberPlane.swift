//
//  NumberPlane.swift
//  Manim
//
//  Created by Vaida on 8/26/24.
//

import PythonKit

/// Creates a number plane that spans the entire screen.
///
/// ![example](VectorArrow)
public class NumberPlane: Axes {
    
    public convenience init(domain: ClosedRange<Double>, range: ClosedRange<Double>) {
        self.init(domain: Range(domain), range: Range(range))
    }
    
    /// Creates a set of axes.
    ///
    /// Note that the axes coordinate space is the same as global coordinate space.
    ///
    /// - Parameters:
    ///   - domain: The `(x_min, x_max, x_step)` values of the x-axis.
    ///   - range: The `(y_min, y_max, y_step)` values of the y-axis.
    public override init(domain: Range? = nil, range: Range? = nil) {
        let args: Closure.Arguments = [
            ("x_range", domain),
            ("y_range", range),
            ("x_length", manim.config.frame_width),
            ("y_length", manim.config.frame_height)
        ]
        
        super.init(manim.NumberPlane.dynamicallyCall(withKeywordArguments: args))
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
