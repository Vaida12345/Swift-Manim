//
//  Dot.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//



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
    public init(point: any PointLike = .center, radius: Double? = nil, strokeWidth: Double = 0, opacity: Double = 1.0, color: Color? = nil) {
        super.init(args: [
            ("point", point.pyDescription),
            ("radius", radius?.description),
            ("stroke_width", strokeWidth.description),
            ("fill_opacity", opacity.description),
            ("color", color?.pyDescription),
        ])
    }
    
    
    required init(identifier: String) { super.init(args: []) }
    
}
