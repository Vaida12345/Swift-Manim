//
//  Dot.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import PythonKit


/// A dot
public final class Dot: Circle {
    
    
    /// Creates a dot
    ///
    /// - Parameters:
    ///   - point: The location of the dot.
    ///   - radius: The radius of the dot.
    ///   - color: The color of the dot.
    public init(at point: Point = .center, radius: Double = 0.08, color: Color = .white) {
        let object = manim.Dot(point: point, radius: radius, fill_opacity: color.alpha, color: color)
        super.init(object)
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
