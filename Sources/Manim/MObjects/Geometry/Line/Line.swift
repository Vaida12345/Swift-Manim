//
//  Line.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import OSLog
import PythonKit


public class Line: TipableVMObject {
    
    public init(from start: Point, to end: Point, color: Color) {
        super.init(manim.Line(start: start, end: end, color: color))
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}


extension Line {
    
    /// Moves the ``MObject/start`` and ``MObject/end``.
    @discardableResult
    public func moveTo(start: Point, end: Point) -> AttachedAnimation {
        AttachedAnimation(base: self._transformable, closure: Closure("put_start_and_end_on", [("", start), ("", end)]))
    }
    
}
