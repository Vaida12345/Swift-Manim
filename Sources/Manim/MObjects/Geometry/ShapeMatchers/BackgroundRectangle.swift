//
//  BackgroundRectangle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//




/// A background rectangle. Its default color is the background color of the scene.
public final class BackgroundRectangle: SurroundingRectangle {
    
    /// Creates a background rectangle.
    ///
    /// - Parameters:
    ///   - base: The attached object.
    ///   - stroke: The stroke width and opacity.
    ///   - fill: The fill color and opacity.
    public convenience init(base: MObject, stroke: (width: (any Number)?, opacity: (any Number)?)? = nil, fill: (color: (any Number)?, opacity: (any Number)?)? = nil) {
        self.init(arguments: [
            ("mobject", base.identifier),
            ("color", fill?.color?.representation),
            ("stroke_width", stroke?.width?.representation),
            ("stroke_opacity", stroke?.opacity?.representation),
            ("fill_opacity", fill?.opacity?.representation),
        ])
    }
    
}
