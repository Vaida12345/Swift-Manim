//
//  Text.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//




/// Display (non-LaTeX) text.
public class Text: SVGMObject {
    
    /// Write-only property for setting fontSize.
    public var fontSize: Double {
        get { fatalError("Does not support GET") }
        set { self.addInitializerArgument("font_size", newValue.description) }
    }
    
    /// Write-only property for setting font.
    public var font: String {
        get { fatalError("Does not support GET") }
        set { self.addInitializerArgument("font", newValue.description) }
    }
    
    /// Write-only property for setting italic.
    public var italic: Bool {
        get { fatalError("Does not support GET") }
        set { self.addInitializerArgument("slant", newValue ? "ITALIC" : "NORMAL") }
    }
    
    /// Write-only property for setting fontWeight.
    public var fontWeight: FontWeight {
        get { fatalError("Does not support GET") }
        set { self.addInitializerArgument("weight", newValue) }
    }
    
    
    public init(_ text: String, lineSpacing: Double = -1, height: Double? = nil, width: Double? = nil, center: Bool = true) {
        var arguments = Closure.Arguments()
        arguments.append("text", "\"\(text)\"")
        arguments.append("line_spacing", lineSpacing.description, when: .notEqual("-1.0"))
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
