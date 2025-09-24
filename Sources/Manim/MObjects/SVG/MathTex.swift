//
//  MathTex.swift
//  Manim
//
//  Created by Vaida on 8/26/24.
//

import PythonKit


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
        super.init(manim.MathTex(latex.content))
    }
    
    @_disfavoredOverload
    public required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    
    public struct TextInterpolation: StringInterpolationProtocol, ExpressibleByStringInterpolation {
        
        public init(stringInterpolation: MathTex.TextInterpolation) {
            self.content = stringInterpolation.content
        }
        
        public init(stringLiteral value: String) {
            self.content = value
        }
        
        var content: String
        
        public mutating func appendLiteral(_ literal: String) {
            self.content += literal
        }
        
        public mutating func appendInterpolation(_ value: Any) {
            self.content += "\(value)"
        }
        
        
        public init(literalCapacity: Int, interpolationCount: Int) {
            self.content = ""
        }
        
        public typealias StringInterpolation = Self
        
    }
    
}
