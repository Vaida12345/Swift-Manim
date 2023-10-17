//
//  SurroundingRectangle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//




/// A rectangle surrounding an object
public class SurroundingRectangle: MObject {
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    /// Creates the rectangle.
    ///
    /// - Parameters:
    ///   - base: The attached object.
    ///   - color: The color of stroke.
    ///   - cornerRadius: The color radius of stroke.
    public init(_ base: MObject, color: Color? = nil, cornerRadius: Double? = nil) {
        super.init(args: [
            ("mobject", base.identifier),
            ("color", color?.pyDescription),
            ("corner_radius", cornerRadius?.description),
        ])
    }
    
    override init(base: String? = nil, args: Args) {
        super.init(base: base, args: args)
    }
    
}
