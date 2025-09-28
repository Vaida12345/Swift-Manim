//
//  MathTex.swift
//  Manim
//
//  Created by Vaida on 8/26/24.
//

import PythonKit


/// A string compiled with LaTeX in math mode.
///
/// > Tip:
/// > You can use the variadic argument to specify groups.
/// > ```swift
/// > MathTex("5", "14")
/// > ```
/// >
/// > In this way, you can use ``VMObject/children`` to access the sub objects.
public class MathTex: SVGMObject {
    
    /// Creates a string.
    ///
    /// > Tip:
    /// > You can use the variadic argument to specify groups.
    /// > ```swift
    /// > MathTex("5", "14")
    /// > ```
    /// >
    /// > In this way, you can use ``VMObject/children`` to access the sub objects.
    public init(_ latex: String...) {
        super.init(_pythonObject: manim.MathTex(latex.map({ "{{\($0)}}" }).joined()))
    }
    
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, defaultColor: Color = .white, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, defaultColor: defaultColor, builder)
    }
    
}
