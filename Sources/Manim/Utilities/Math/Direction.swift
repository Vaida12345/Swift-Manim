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
    case up
    case down
    
    public var pythonObject: PythonObject {
        switch self {
        case .left:
            manim.LEFT
        case .right:
            manim.RIGHT
        case .up:
            manim.UP
        case .down:
            manim.DOWN
        }
    }
}
