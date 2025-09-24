//
//  Text.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import PythonKit


/// Display (non-LaTeX) text.
///
/// - SeeAlso: ``MathTex`` for LaTeX text.
public class Text: SVGMObject {
    
    public init(_ text: String, opacity: Double = 1, strokeWidth: Double = 0, color: Color = .white, fontSize: Double = 48, lineSpacing: Double = -1, font: String = "", italic: Bool = false, weight: FontWeight = .normal) {
        var arguments = Closure.Arguments()
        arguments.append("text", text)
        arguments.append("fill_opacity", opacity)
        arguments.append("stroke_width", strokeWidth)
        arguments.append("color", color)
        arguments.append("font_size", fontSize)
        arguments.append("line_spacing", lineSpacing)
        arguments.append("font", font)
        arguments.append("slant", italic ? "ITALIC" : "NORMAL")
        arguments.append("weight", weight)
        
        super.init(manim.Text.dynamicallyCall(withKeywordArguments: arguments))
    }
    
    @_disfavoredOverload
    public required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    public enum FontWeight: String, PythonConvertible {
        case normal
        case bold
        
        public var pythonObject: PythonObject {
            self.rawValue.uppercased().pythonObject
        }
    }
    
}
