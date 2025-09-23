//
//  MathTex.swift
//  Manim
//
//  Created by Vaida on 8/26/24.
//


/// A LaTeX text.
///
/// > Tip:
/// > You can use ``{{}}`` to separate a tex into groups.
/// > ```swift
/// > MathTex("{{5}}+{{14}}")
/// > ```
/// >
/// > In this way, you can use ``MObject/children`` to access the sub objects.
public class MathTex: SVGMObject {
    
    public init(_ latex: TextInterpolation) {
        super.init(arguments: [(nil, latex.content)])
    }
    
    
    required init(identifier: String) { super.init(identifier: identifier) }
    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) { super.init(typeIdentifier, arguments: arguments) }
    
    
    public struct TextInterpolation: StringInterpolationProtocol, ExpressibleByStringInterpolation {
        
        public init(stringInterpolation: MathTex.TextInterpolation) {
            self.content = stringInterpolation.content
        }
        
        public init(stringLiteral value: String) {
            self.content = "r\"\(value)\""
        }
        
        var content: String
        
        public mutating func appendLiteral(_ literal: String) {
            if !content.isEmpty {
                self.content += "+ r\"\(literal)\""
            } else {
                self.content += "\"\(literal)\""
            }
        }
        
        public mutating func appendInterpolation(_ value: Any) {
            self.content += "+ f\"{\(value)}\""
        }
        
        
        public init(literalCapacity: Int, interpolationCount: Int) {
            self.content = ""
        }
        
        public typealias StringInterpolation = Self
        
    }
    
}
