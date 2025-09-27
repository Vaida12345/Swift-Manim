//
//  Range.swift
//  Manim
//
//  Created by Vaida on 2025-09-24.
//

import Foundation
import PythonKit


/// A numeric range defined by a minimum value, a maximum value, and an optional step size.
/// 
/// This struct represents a contiguous sequence of values starting at `min`, ending at `max`, and incrementing by `step`.
@MainActor
public struct Range: @MainActor PythonConvertible {
    
    let min: Double
    
    let max: Double
    
    let step: Double
    
    
    public var pythonObject: PythonObject {
        numpy.array([min, max, step])
    }
    
    public var length: Double {
        self.max - self.min
    }
    
    
    /// Creates an range given its `(min, max, step)` values of the axis.
    ///
    /// Initializes a `Range` with a lower bound, an upper bound, and an optional step increment.
    ///
    /// - Parameters:
    ///   - min: The starting value of the range (inclusive).
    ///   - max: The ending value of the range (inclusive).
    ///   - step: The amount by which the value increases on each iteration. Defaults to `1`.
    public init(_ min: Double, _ max: Double, step: Double = 1) {
        self.min = min
        self.max = max
        self.step = step
    }
    
    /// Initializes a `Range` from the bounds of a `ClosedRange<Double>`, using a default step size of 1.
    ///
    /// - Parameter range: A closed range whose `lowerBound` and `upperBound` define the inclusive start and end values for the new `Range`.
    public init(_ range: ClosedRange<Double>) {
        self.min = range.lowerBound
        self.max = range.upperBound
        self.step = 1
    }
    
    /// Adjust the max by `+1` to make space for `tip`.
    func _adjustForTip(hasTip: Bool) -> Range {
        Range(self.min, self.max + 1, step: self.step)
    }
    
}
    
