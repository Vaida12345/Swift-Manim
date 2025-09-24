//
//  RegularPolygon.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


/// An n-sided regular Polygon.
public class RegularPolygon: RegularPolygram {
    
    
    /// - Parameters:
    ///   - n: The number of sides of the RegularPolygon.
    ///   - color: The stroke color.
    public init(n: Int, color: Color) {
        super.init(manim.RegularPolygon(n: n, color: color))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
