//
//  CurvedArrow.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import PythonKit
import SwiftUI


public class CurvedArrow: ArcBetweenPoints {
    
    public init(start: Point, end: Point, angle: Angle = .degrees(45)) {
        super.init(manim.CurvedArrow(start_point: start, end_point: end, angle: angle.radians))
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
