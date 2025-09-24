//
//  Square.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import PythonKit


/// A square.
public final class Square: Rectangle {
    
    /// Creates a square.
    ///
    /// - Parameters:
    ///   - length: The length for each side.
    ///   - color: The stroke color.
    ///   - gridStep: Space between horizontal and vertical grid lines.
    public init(length: Double, color: Color = .yellow, gridStep: (x: Double?, y: Double?)? = nil) {
        super.init(manim.Square(side_length: length, color: color, grid_xstep: gridStep?.x, grid_ystep: gridStep?.y))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
