//
//  Ellipse.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import PythonKit


/// Am ellipse
public final class Ellipse: Circle {
    
    
    public init(width: Double, height: Double, color: Color) {
        super.init(manim.Ellipse(width: width, height: height, color: color))
    }
    
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
