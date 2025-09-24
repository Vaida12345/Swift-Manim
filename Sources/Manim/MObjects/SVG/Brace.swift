//
//  Brace.swift
//  Manim
//
//  Created by Vaida on 8/27/24.
//

import PythonKit


/// Takes a ``MObject`` and draws a brace adjacent to it.
public class Brace: MObject {
    
    /// - Parameters:
    ///   - direction: Passing a direction vector determines the direction from which the brace is drawn.
    public init(_ object: MObject, direction: Direction = .down) {
        super.init(manim.Brace(object, direction: direction))
    }
    
    @_disfavoredOverload
    public required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
