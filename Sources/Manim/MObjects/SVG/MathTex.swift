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
/// > You can use the variadic argument to specify groups.
/// > ```swift
/// > MathTex("5", "14")
/// > ```
/// >
/// > In this way, you can use ``MObject/children`` to access the sub objects.
public class MathTex: SVGMObject {
    
    public init(_ latex: String...) {
        super.init(manim.MathTex(latex.map({ "{{\($0)}}" }).joined()))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
