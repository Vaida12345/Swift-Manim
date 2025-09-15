//
//  Variables.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//



@MainActor
var shouldUseAnimation = false

@MainActor
var indentCount: Int = 2

@MainActor
var variableCounter: [String: Int] = [:]

@MainActor
var shouldUseAnimationBuffer: Bool = false
@MainActor
var animationBuffer: [Animation] = []

/// If `true`, when calling PyObject.init(base:args:), store the initializer instead of creating the class.
@MainActor
var shouldOverrideInit = false
