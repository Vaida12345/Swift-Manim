//
//  RegularPolygram.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//


import SwiftUI


/// A Polygram with regularly spaced vertices.
public class RegularPolygram: Polygram {
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    /// Creates a ``RegularPolygram``.
    ///
    /// - Parameters:
    ///   - count: The number of vertices.
    ///   - density: Can be thought of as how many vertices to hop to draw a line between them. Every `density`-th vertex is connected.
    ///   - radius: The radius of the circle that the vertices are placed on.
    ///   - startAngle: The angle the vertices start at; the rotation of the ``RegularPolygram``.
    public init(count: Int, density: Int? = nil, radius: Double? = nil, startAngle: Angle? = nil) {
        super.init(args: [
            ("num_vertices", count.description),
            ("density", density?.description),
            ("radius", radius?.description),
            ("start_angle", startAngle?.radians.description),
        ])
    }
    
    override init(base: String? = nil, args: Closure.Arguments) {
        super.init(base: base, args: args)
    }
    
}
