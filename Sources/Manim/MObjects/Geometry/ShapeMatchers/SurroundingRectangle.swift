//
//  SurroundingRectangle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//




/// A rectangle surrounding an object
public class SurroundingRectangle: MObject {
    
    /// Creates the rectangle.
    ///
    /// - Parameters:
    ///   - base: The attached object.
    ///   - color: The color of stroke.
    ///   - cornerRadius: The color radius of stroke.
    public init(_ base: MObject, color: Color? = nil, cornerRadius: (any Number)? = nil) {
        super.init(arguments: [
            ("mobject", base.identifier),
            ("color", color?.representation),
            ("corner_radius", cornerRadius?.representation),
        ])
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) { super.init(typeIdentifier, arguments: arguments) }
    
}
