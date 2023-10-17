//
//  Rectangle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//




/// A Rectangle
public class Rectangle: Polygon {
    
    
    /// Creates a rectangle.
    ///
    /// - Parameters:
    ///   - gridStep: Space between horizontal and vertical grid lines.
    public init(height: Double = 2, width: Double = 4, gridStep: (x: Double?, y: Double?)?) {
        super.init(args: [("height", height.description),
                          ("width", width.description),
                          ("grid_xstep", gridStep?.x?.description),
                          ("grid_ystep", gridStep?.y?.description),
                         ])
    }
    
    override init(base: String? = nil, args: Args) {
        super.init(base: base, args: args)
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    
}
