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
    
    public init(_ text: String, strokeWidth: Double = 0, color: Color = .white, fontSize: Double = 48, lineSpacing: Double = -1, font: String = "", italic: Bool = false, weight: FontWeight = .normal) {
        var arguments = Closure.Arguments()
        arguments.append("text", text)
        arguments.append("fill_opacity", color.alpha)
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
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    public enum FontWeight: String, PythonConvertible {
        case normal
        case bold
        
        public var pythonObject: PythonObject {
            self.rawValue.uppercased().pythonObject
        }
    }
    
}

extension Text {
    
    public var fontSize: Int {
        get { Int(self.pythonObject.font_size)! }
        set { self.pythonObject.font_size = newValue.pythonObject }
    }
    
    public var font: String {
        get { String(self.pythonObject.font)! }
        set { self.pythonObject.font = newValue.pythonObject }
    }
    
    public var weight: Int {
        get { Int(self.pythonObject.weight)! }
        set { self.pythonObject.weight = newValue.pythonObject }
    }
    
}
