//
//  CubicBezier.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import PythonKit


/// A cubic Bézier curve.
final class CubicBezier: VMObject {
    
    /// Creates a bezier using the coordinates of `anchor` and `handle`.
    public init(start: Control, end: Control) {
        super.init(manim.CubicBezier(start_anchor: start.anchor, start_handle: start.handle, end_anchor: end.anchor, end_handle: end.handle))
    }
    
    
    public struct Control {
        
        let anchor: Point, handle: Point
        
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
