//
//  Variables.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import PythonKit

/// Tracks whether the code is executed within `withAnimation` block.
@MainActor var shouldUseAnimation: Bool = false

@MainActor var _manim: PythonObject? = nil
/// The shared `manim` package instance.
@MainActor
var manim: PythonObject {
    guard let manim = _manim else {
        fatalError("Please make sure all logics are implemented within `withManim(scene:configuration:)`.")
    }
    return manim
}
@MainActor var _numpy: PythonObject? = nil
/// The shared `numpy` package instance.
@MainActor
var numpy: PythonObject {
    guard let numpy = _numpy else {
        fatalError("Please make sure all logics are implemented within `withManim(scene:configuration:)`.")
    }
    return numpy
}
@MainActor var _scene: PythonObject? = nil
/// The shared scene
@MainActor
var scene: PythonObject {
    guard let scene = _scene else {
        fatalError("Please make sure all logics are implemented within `withManim(scene:configuration:)`.")
    }
    return scene
}
