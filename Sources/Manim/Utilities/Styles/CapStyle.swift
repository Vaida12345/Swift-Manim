//
//  CapStyle.swift
//  Manim
//
//  Created by Vaida on 2025-09-25.
//

import PythonKit


@MainActor
public enum CapStyle: @MainActor PythonConvertible, @MainActor ConvertibleFromPython, CaseIterable, @MainActor CustomStringConvertible {
    case auto, round, butt, square
    
    public var description: String {
        switch self {
        case .auto: ".auto"
        case .round: ".round"
        case .butt: ".butt"
        case .square: ".square"
        }
    }
    
    public var pythonObject: PythonObject {
        switch self {
        case .auto:
            manim.CapStyleType.AUTO
        case .round:
            manim.CapStyleType.ROUND
        case .butt:
            manim.CapStyleType.BUTT
        case .square:
            manim.CapStyleType.SQUARE
        }
    }
    
    public init?(_ object: PythonObject) {
        switch object {
        case manim.CapStyleType.AUTO:
            self = .auto
        case manim.CapStyleType.ROUND:
            self = .round
        case manim.CapStyleType.BUTT:
            self = .butt
        case manim.CapStyleType.SQUARE:
            self = .square
        default:
            return nil
        }
    }
}
