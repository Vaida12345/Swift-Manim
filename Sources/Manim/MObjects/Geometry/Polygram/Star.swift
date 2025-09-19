//
//  Star.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//


import SwiftUI


/// A regular polygram without the intersecting lines.
public final class Star: Polygram {
    
    /// Creates a star.
    ///
    /// - Parameters:
    ///   - count: How many points on the Star.
    ///   - radius: The radius of the circle that the inner / outer vertices are placed on.
    public convenience init(count: Int? = nil, radius: (inner: Double?, outer: Double?)? = nil, startAngle: Angle? = nil) {
        self.init(arguments: [
            ("n", count?.description),
            ("outer_radius", radius?.outer?.description),
            ("inner_radius", radius?.outer?.description),
            ("start_angle", startAngle?.radians.description),
        ])
    }
    
}
