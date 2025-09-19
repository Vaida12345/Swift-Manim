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
    ///   - height: The height of the rectangle
    ///   - width: The width of the rectangle
    ///   - gridStep: Space between horizontal and vertical grid lines.
    public init(height: Double = 2, width: Double = 4, gridStep: (x: Double?, y: Double?)?) {
        super.init(arguments: [("height", height.description),
                          ("width", width.description),
                          ("grid_xstep", gridStep?.x?.description),
                          ("grid_ystep", gridStep?.y?.description),
                         ])
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) { super.init(typeIdentifier, arguments: arguments) }
    
}
