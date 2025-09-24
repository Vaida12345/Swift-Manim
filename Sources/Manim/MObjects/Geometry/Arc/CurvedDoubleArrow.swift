//
//  CurvedDoubleArrow.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import PythonKit
import SwiftUI


public final class CurvedDoubleArrow: CurvedArrow {
    
    public override init(start: Point, end: Point, angle: Angle = .degrees(45)) {
        super.init(manim.CurvedDoubleArrow(start_point: start, end_point: end, angle: angle.radians))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
