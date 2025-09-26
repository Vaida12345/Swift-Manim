//
//  CubicBezier.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import PythonKit


/// A cubic Bézier curve.
public final class CubicBezier: VMObject {
    
    /// Creates a bezier using the coordinates of `anchor` and `handle`.
    public init(start: Control, end: Control) {
        super.init(manim.CubicBezier(start_anchor: start.anchor, start_handle: start.handle, end_anchor: end.anchor, end_handle: end.handle))
    }
    
    /// A control point for cubic Bézier curve.
    public struct Control {
        
        let anchor: Point, handle: Point
        
        
        public init(anchor: Point, handle: Point) {
            self.anchor = anchor
            self.handle = handle
        }
        
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
