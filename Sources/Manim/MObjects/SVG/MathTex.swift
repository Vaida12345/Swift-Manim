//
//  MathTex.swift
//  Manim
//
//  Created by Vaida on 8/26/24.
//


public class MathTex: SVGMObject {
    
    public init(_ latex: TextInterpolation) {
        super.init(args: [(nil, latex.content)])
    }
    
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    
    public struct TextInterpolation: StringInterpolationProtocol, ExpressibleByStringInterpolation {
        
        public init(stringInterpolation: MathTex.TextInterpolation) {
            self.content = stringInterpolation.content
        }
        
        public init(stringLiteral value: String) {
            self.content = "\"\(value)\""
        }
        
        var content: String
        
        public mutating func appendLiteral(_ literal: String) {
            if !content.isEmpty {
                self.content += "+ \"\(literal)\""
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
