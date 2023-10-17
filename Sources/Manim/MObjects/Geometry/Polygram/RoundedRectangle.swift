//
//  RoundedRectangle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//




public final class RoundedRectangle: Rectangle {
    
    /// Creates a rectangle.
    ///
    /// - Parameters:
    ///   - gridStep: Space between horizontal and vertical grid lines.
    public init(height: Double = 2, width: Double = 4, cornerRadius: Double? = nil, gridStep: (x: Double?, y: Double?)?) {
        super.init(args: [("height", height.description),
                          ("width", width.description),
                          ("corner_radius", cornerRadius?.description),
                          ("grid_xstep", gridStep?.x?.description),
                          ("grid_ystep", gridStep?.y?.description),
                         ])
    }
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
}
