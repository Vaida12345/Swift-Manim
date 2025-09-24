//
//  ArrowTipShape.swift
//  Manim
//
//  Created by Vaida on 2025-09-24.
//

import PythonKit


@MainActor
public enum ArrowTipShape: @MainActor PythonConvertible {
    
    case diamond
    case circle
    case triangle
    
    case diamondFilled
    case circleFilled
    case triangleFilled
    
    public var pythonObject: PythonObject {
        switch self {
        case .diamond:
            manim.ArrowSquareTip
        case .circle:
            manim.ArrowCircleTip
        case .triangle:
            manim.ArrowTriangleTip
        case .diamondFilled:
            manim.ArrowSquareFilledTip
        case .circleFilled:
            manim.ArrowCircleFilledTip
        case .triangleFilled:
            manim.ArrowTriangleFilledTip
        }
    }
    
    public var filled: ArrowTipShape {
        switch self {
        case .diamond: .diamondFilled
        case .circle: .circleFilled
        case .triangle: .triangleFilled
        default: self
        }
    }
}
