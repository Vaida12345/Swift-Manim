//
//  Triangle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


/// A background rectangle. Its default color is the background color of the scene.
public final class Triangle: RegularPolygon {
    
    /// - Parameters:
    ///   - n: The number of sides of the RegularPolygon.
    public init(color: Color) {
        super.init(manim.Triangle(color: color))
    }
    
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
