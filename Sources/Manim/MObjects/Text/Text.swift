//
//  Text.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//




/// Display (non-LaTeX) text.
public class Text: SVGMObject {
    
    public init(_ text: String, opacity: Double = 1, strokeWidth: Double = 0, color: Color = .white, fontSize: Double = 48, lineSpacing: Double = -1, font: String? = nil, italic: Bool = false, weight: FontWeight = .normal, height: Double? = nil, width: Double? = nil, center: Bool = true) {
        super.init(args: [
            ("text", "\"\(text)\""),
            ("fill_opacity", opacity.description),
            ("stroke_width", strokeWidth.description),
            ("color", color.representation),
            ("font_size", fontSize.description),
            ("line_spacing", lineSpacing.description),
            ("font", font),
            ("slant", italic ? "ITALIC" : "NORMAL"),
            ("weight", weight.representation),
            ("height", height?.description),
            ("width", width?.description),
            ("should_center", center.representation),
        ])
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    
    public enum FontWeight: String, PythonScriptConvertible {
        case normal
        case bold
        
        public var representation: String {
            self.rawValue.uppercased()
        }
    }
    
}
