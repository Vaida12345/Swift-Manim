//
//  Position.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import PythonKit


@MainActor
public enum Direction: Equatable, @MainActor PythonConvertible {
    case left
    case right
    case top, up
    case bottom, down
    
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    
    public var pythonObject: PythonObject {
        switch self {
        case .left:
            manim.LEFT
        case .right:
            manim.RIGHT
        case .up, .top:
            manim.UP
        case .down, .bottom:
            manim.DOWN
            
        case .topLeft:
            manim.UL
        case .topRight:
            manim.UR
        case .bottomLeft:
            manim.DL
        case .bottomRight:
            manim.DR
        }
    }
}
