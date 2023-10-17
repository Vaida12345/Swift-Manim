//
//  Cross.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//




public final class Cross: VGroup {
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    /// Creates a cross.
    public init(base: MObject? = nil, stroke: (color: Color?, width: Double?)? = nil) {
        super.init(args: [
            ("mobject", base?.identifier),
            ("stroke_color", stroke?.color?.pyDescription),
            ("stroke_width", stroke?.width?.description),
        ])
    }
    
}
