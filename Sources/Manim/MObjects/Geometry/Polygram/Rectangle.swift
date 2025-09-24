//
//  Rectangle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import PythonKit


/// A Rectangle
public class Rectangle: Polygon {
    
    
    /// Creates a rectangle.
    ///
    /// - Parameters:
    ///   - width: The width of the rectangle
    ///   - height: The height of the rectangle
    ///   - gridStep: Space between horizontal and vertical grid lines.
    public init(width: Double, height: Double, color: Color = .yellow, gridStep: (x: Double?, y: Double?)? = nil) {
        var arguments = Closure.Arguments()
        arguments.append("width", width)
        arguments.append("height", height)
        arguments.append("color", color)
        arguments.append("grid_xstep", gridStep?.x)
        arguments.append("grid_ystep", gridStep?.y)
        
        super.init(manim.Rectangle.dynamicallyCall(withKeywordArguments: arguments))
    }
    
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
