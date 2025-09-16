//
//  Dot.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import MacroCollection


/// A dot
public final class Dot: VMObject {
    
    
    /// Creates a dot
    ///
    /// - Parameters:
    ///   - point: The location of the dot.
    ///   - radius: The radius of the dot.
    ///   - strokeWidth: The thickness of the outline of the dot.
    ///   - opacity: The opacity of the dot’s `color`.
    ///   - color: The color of the dot.
    public init(at point: some PointProtocol = Point.center, radius: Double = 0.08, strokeWidth: Double = 0, opacity: Double = 1.0, color: Color = .white) {
        var arguments = Closure.Arguments()
        arguments.append("point", point.representation, when: .notEqual(Point.center.representation))
        arguments.append("radius", radius.description, when: .notEqual("0.08"))
        arguments.append("stroke_width", strokeWidth.description, when: .notEqual("0.0"))
        arguments.append("fill_opacity", opacity.description, when: .notEqual("1.0"))
        arguments.append("color", color.representation, when: .notEqual(Color.black.representation))
        
        super.init(args: arguments)
    }
    
    
    required init(identifier: String) { super.init(args: []) }
    
}
