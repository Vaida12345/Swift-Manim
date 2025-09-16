//
//  Variables.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//



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
