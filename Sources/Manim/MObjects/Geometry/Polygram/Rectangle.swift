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
    ///   - width: The width of the rectangle
    ///   - height: The height of the rectangle
    ///   - gridStep: Space between horizontal and vertical grid lines.
    public init( width: Double, height: Double, gridStep: (x: Double?, y: Double?)? = nil) {
        var arguments = Closure.Arguments()
        arguments.append("width", width.description)
        arguments.append("height", height.description)
        arguments.append("grid_xstep", gridStep?.x?.description)
        arguments.append("grid_ystep", gridStep?.y?.description)
        
        super.init(arguments: arguments)
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) { super.init(typeIdentifier, arguments: arguments) }
    
}
