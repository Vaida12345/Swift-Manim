//
//  RateFunction.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import PythonKit


/// A selection of rate functions, i.e., speed curves for animations.
@MainActor
public enum RateFunction: @MainActor PythonConvertible {
    
    case easeIn
    case easeOut
    case easeInOut
    case spring
    case linear
    
    public var pythonObject: PythonObject {
        switch self {
        case .easeIn: manim.rate_functions.ease_in_sine
        case .easeOut: manim.rate_functions.ease_out_sine
        case .easeInOut: manim.rate_functions.ease_in_out_sine
        case .spring: manim.rate_functions.exponential_decay
        case .linear: manim.rate_functions.linear
        }
    }
    
}
