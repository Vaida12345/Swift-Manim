//
//  BackgroundRectangle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//




/// A background rectangle. Its default color is the background color of the scene.
public final class BackgroundRectangle: SurroundingRectangle {
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    /// Creates a background rectangle.
    ///
    /// - Parameters:
    ///   - base: The attached object.
    ///   - stroke: The stroke width and opacity.
    ///   - fill: The fill color and opacity.
    public init(base: MObject, stroke: (width: Double?, opacity: Double?)? = nil, fill: (color: Color?, opacity: Double?)? = nil) {
        super.init(args: [
            ("mobject", base.identifier),
            ("color", fill?.color?.pyDescription),
            ("stroke_width", stroke?.width?.description),
            ("stroke_opacity", stroke?.opacity?.description),
            ("fill_opacity", fill?.opacity?.description),
        ])
    }
    
}
