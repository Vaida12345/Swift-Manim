//
//  Text.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import Foundation


/// Display (non-LaTeX) text.
public class Text: SVGMObject {
    
    init(_ text: String, opacity: Double = 1, strokeWidth: Double = 0, color: Color = .white, fontSize: Double = 48, lineSpacing: Double = -1, font: String? = nil, italic: Bool = false, weight: FontWeight = .normal, height: Double? = nil, width: Double? = nil, center: Bool = true) {
        super.init(args: [
            ("text", "\"\(text)\""),
            ("fill_opacity", opacity.description),
            ("stroke_width", strokeWidth.description),
            ("color", color.pyDescription),
            ("font_size", fontSize.description),
            ("line_spacing", lineSpacing.description),
            ("font", font),
            ("slant", italic ? "ITALIC" : "NORMAL"),
            ("weight", weight.pyDescription),
            ("height", height?.description),
            ("width", width?.description),
            ("should_center", center.pyDescription),
        ])
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    
    enum FontWeight: String {
        case normal
        case bold
        
        var pyDescription: String {
            self.rawValue.uppercased()
        }
    }
    
}
