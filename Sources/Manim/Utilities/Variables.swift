//
//  Variables.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import PythonKit


/// Tracks whether the code is executed in `withAnimation` block.
@MainActor
var shouldUseAnimation = false

/// Counter for each variable, used to form variable names.
@MainActor
var variableCounter: [String: Int] = [:]

/// If `true`, when calling PyObject.init(base:args:), store the initializer instead of creating the class.
///
/// Use this to support user creating their own classes.
@MainActor
var shouldOverrideInit = false



@MainActor var _manim: PythonObject? = nil
/// The shared `manim` package instance.
@MainActor
var manim: PythonObject {
    guard let manim = _manim else {
        fatalError("Please make sure all logics are implemented within `withManim(scene:configuration:)`.")
    }
    return manim
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
