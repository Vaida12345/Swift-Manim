//
//  Text.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//




/// Display (non-LaTeX) text.
public class Text: SVGMObject {
    
    public init(_ text: String, opacity: Double = 1, strokeWidth: Double = 0, color: Color = .white, fontSize: Double = 48, lineSpacing: Double = -1, font: String? = nil, italic: Bool = false, weight: FontWeight = .normal, height: Double? = nil, width: Double? = nil, center: Bool = true) {
        var arguments = Closure.Arguments()
        arguments.append("text", "\"\(text)\"")
        arguments.append("fill_opacity", opacity.description, when: .notEqual("1.0"))
        arguments.append("stroke_width", strokeWidth.description, when: .notEqual("0.0"))
        arguments.append("color", color, when: .notEqual(.white))
        arguments.append("font_size", fontSize.description, when: .notEqual("48.0"))
        arguments.append("line_spacing", lineSpacing.description, when: .notEqual("-1.0"))
        arguments.append("font", font)
        arguments.append("slant", italic ? "ITALIC" : "NORMAL", when: .notEqual("NORMAL"))
        arguments.append("weight", weight, when: .notEqual(.normal))
        arguments.append("height", height?.description)
        arguments.append("width", width?.description)
        arguments.append("center", center, when: .notEqual(true))
        
        super.init(arguments: arguments)
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) { super.init(typeIdentifier, arguments: arguments) }
    
    public enum FontWeight: String, PythonScriptConvertible {
        case normal
        case bold
        
        public var representation: String {
            self.rawValue.uppercased()
        }
    }
    
}
