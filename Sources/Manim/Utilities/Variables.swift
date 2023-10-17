//
//  Variables.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//




var shouldUseAnimation = false

var indentCount: Int = 2

var variableCounter: [String: Int] = [:]

var shouldUseAnimationBuffer: Bool = false
var animationBuffer: [Animation] = []

/// If `true`, when calling PyObject.init(base:args:), store the initializer instead of creating the class.
var shouldOverrideInit = false
