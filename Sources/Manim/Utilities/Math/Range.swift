//
//  Range.swift
//  Manim
//
//  Created by Vaida on 2025-09-24.
//

import Foundation
import PythonKit


@MainActor
public struct Range: @MainActor PythonConvertible {
    
    let min: Double
    
    let max: Double
    
    let step: Double
    
    
    public var pythonObject: PythonObject {
        [min, max, step].pythonObject
    }
    
    var length: Double {
        self.max - self.min
    }
    
    
    /// Creates an range given its `(min, max, step)` values of the axis.
    public init(_ min: Double, _ max: Double, step: Double = 1) {
        self.min = min
        self.max = max
        self.step = step
    }
    
    public init(_ range: ClosedRange<Double>) {
        self.min = range.lowerBound
        self.max = range.upperBound
        self.step = 1
    }
    
}
    
