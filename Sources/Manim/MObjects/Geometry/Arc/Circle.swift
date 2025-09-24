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
    public init(radius: Double? = nil, strokeColor: Color? = nil) {
        let object = manim.Circle(radius: radius, color: strokeColor)
        super.init(object)
    }
    
    
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
