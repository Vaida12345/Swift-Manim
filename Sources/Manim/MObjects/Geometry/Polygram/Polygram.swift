//
//  Polygram.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


/// A generalized Polygon, allowing for disconnected sets of edges.
public class Polygram: VMObject {
    
    /// Creates a polygram by connecting the dots in sequence.
    public init(vertices: [Point], color: Color) {
        super.init(manim.Polygram(vertices, color: color))
    }
    
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    /// Rounds off the corners of the Polygram.
    ///
    /// - Parameters:
    ///   - radius: The curvature of the corners of the Polygram.
    public func roundCorners(radius: Double? = nil) -> Polygram {
        let polygram = self.copied()
        polygram.pythonObject.round_corners(radius: radius)
        return polygram
    }
    
}
