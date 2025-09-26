//
//  Brace.swift
//  Manim
//
//  Created by Vaida on 8/27/24.
//

import PythonKit


/// Takes a ``MObject`` and draws a brace adjacent to it.
public class Brace: VMObject {
    
    /// - Parameters:
    ///   - object: The object that is braced.
    ///   - direction: Passing a direction vector determines the direction from which the brace is drawn.
    public init(_ object: MObject, direction: Direction = .bottom) {
        super.init(manim.Brace(object.pythonObject, direction: direction))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
