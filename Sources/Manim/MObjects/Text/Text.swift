//
//  Text.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//




/// Display (non-LaTeX) text.
///
/// - SeeAlso: ``MathTex`` for LaTeX text.
//public class Text: SVGMObject {
//    
//    /// Write-only property for setting fontSize.
//    public var fontSize: (any Number) {
//        get { fatalError("Does not support GET") }
//        set { self.addInitializerArgument("font_size", newValue.representation) }
//    }
//    
//    /// Write-only property for setting font.
//    public var font: String {
//        get { fatalError("Does not support GET") }
//        set { self.addInitializerArgument("font", newValue.description) }
//    }
//    
//    /// Write-only property for setting italic.
//    public var italic: Bool {
//        get { fatalError("Does not support GET") }
//        set { self.addInitializerArgument("slant", newValue ? "ITALIC" : "NORMAL") }
//    }
//    
//    /// Write-only property for setting fontWeight.
//    public var fontWeight: FontWeight {
//        get { fatalError("Does not support GET") }
//        set { self.addInitializerArgument("weight", newValue) }
//    }
//    
//    
//    public init(_ text: String, lineSpacing: (any Number) = -1, height: (any Number)? = nil, width: (any Number)? = nil, center: Bool = true) {
//        var arguments = Closure.Arguments()
//        arguments.append("text", "\"\(text)\"")
//        arguments.append("line_spacing", lineSpacing.representation, when: .notEqual("-1.0"))
//        arguments.append("height", height?.representation)
//        arguments.append("width", width?.representation)
//        arguments.append("center", center, when: .notEqual(true))
//        
//        super.init(arguments: arguments)
//    }
//    
//    required init(identifier: String) { super.init(identifier: identifier) }
//    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) { super.init(typeIdentifier, arguments: arguments) }
//    
//    public enum FontWeight: String, PythonScriptConvertible {
//        case normal
//        case bold
//        
//        public var representation: String {
//            self.rawValue.uppercased()
//        }
//    }
//    
//}
