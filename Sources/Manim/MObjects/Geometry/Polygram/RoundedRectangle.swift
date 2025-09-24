//
//  RoundedRectangle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


public class RoundedRectangle: Rectangle {
    
    /// Creates a rectangle.
    ///
    /// - Parameters:
    ///   - height: The height of the rectangle
    ///   - width: The width of the rectangle
    ///   - cornerRadius: The corner radius of the rectangle
    ///   - gridStep: Space between horizontal and vertical grid lines.
    public init(width: Double, height: Double, cornerRadius: Double = 0.5, gridStep: (x: Double?, y: Double?)? = nil) {
        var arguments = Closure.Arguments()
        arguments.append("width", width)
        arguments.append("height", height)
        arguments.append("corner_radius", cornerRadius)
        arguments.append("grid_xstep", gridStep?.x)
        arguments.append("grid_ystep", gridStep?.y)
        
        super.init(manim.RoundedRectangle.dynamicallyCall(withKeywordArguments: arguments))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
