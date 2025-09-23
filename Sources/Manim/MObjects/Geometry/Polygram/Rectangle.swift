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
    public init(width: some Number, height: some Number, gridStep: (x: (any Number)?, y: (any Number)?)? = nil) {
        var arguments = Closure.Arguments()
        arguments.append("width", width.representation)
        arguments.append("height", height.representation)
        arguments.append("grid_xstep", gridStep?.x?.representation)
        arguments.append("grid_ystep", gridStep?.y?.representation)
        
        super.init(arguments: arguments)
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) { super.init(typeIdentifier, arguments: arguments) }
    
}
