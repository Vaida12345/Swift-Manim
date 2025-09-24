//
//  Polygon.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


/// A shape consisting of one closed loop of vertices.
public class Polygon: Polygram {
    
    /// Creates a polygram by connecting the dots in sequence.
    public override init(vertices: [Point], color: Color) {
        super.init(manim.Polygon(vertices, color: color))
    }
    
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
