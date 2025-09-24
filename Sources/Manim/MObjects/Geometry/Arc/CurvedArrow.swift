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
    
    
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
