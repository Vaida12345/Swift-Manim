//
//  Tex.swift
//  Manim
//
//  Created by Vaida on 2025-09-26.
//

import PythonKit


/// A string compiled with LaTeX in normal mode.
///
/// > Tip:
/// > You can use the variadic argument to specify groups.
/// > ```swift
/// > Tex("5", "14")
/// > ```
/// >
/// > In this way, you can use ``MObject/children`` to access the sub objects.
public final class Tex: MathTex {
    
    /// Creates a string.
    ///
    /// > Tip:
    /// > You can use the variadic argument to specify groups.
    /// > ```swift
    /// > Tex("5", "14")
    /// > ```
    /// >
    /// > In this way, you can use ``MObject/children`` to access the sub objects.
    public override init(_ latex: String...) {
        super.init(manim.Tex(latex.map({ "{{\($0)}}" }).joined()))
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
