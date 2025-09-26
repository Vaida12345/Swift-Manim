//
//  SurroundingRectangle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//

import PythonKit


/// A rectangle surrounding an object
public class SurroundingRectangle: RoundedRectangle {
    
    /// Creates the rectangle.
    ///
    /// - Parameters:
    ///   - base: The attached object.
    ///   - color: The color of stroke.
    ///   - cornerRadius: The color radius of stroke.
    public init(_ base: MObject, color: Color = .yellow, cornerRadius: Double = 0.5) {
        super.init(manim.SurroundingRectangle(base.pythonObject, color: color, corner_radius: cornerRadius))
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
