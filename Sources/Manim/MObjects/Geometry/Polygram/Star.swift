//
//  Star.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit
import SwiftUI


/// A regular polygram without the intersecting lines.
public final class Star: Polygram {
    
    /// Creates a star.
    ///
    /// - Parameters:
    ///   - n: How many points on the Star.
    ///   - radius: The radius of the circle that the inner / outer vertices are placed on.
    public init(n: Int = 5, innerRadius: Double? = nil, outerRadius: Double = 1, startAngle: Angle = .radians(1.5707963267948966), color: Color = .yellow) {
        super.init(manim.Star(n: n, inner_radius: innerRadius, outer_radius: outerRadius, start_angle: startAngle.radians, color: color))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
