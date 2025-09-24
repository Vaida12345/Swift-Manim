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
    ///   - color: The color of the shape.
    public init(radius: Double? = nil, color: Color = .yellow) {
        let object = manim.Circle(radius: radius, color: color)
        super.init(object)
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
