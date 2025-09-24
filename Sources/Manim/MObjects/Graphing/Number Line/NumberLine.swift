//
//  NumberLine.swift
//
//
//  Created by Vaida on 2023/10/17.
//

import PythonKit


/// Creates a number line with tick marks.
public final class NumberLine: Line {
    
    /// Creates a number line with tick marks.
    ///
    /// - Parameters:
    ///   - range: The range of the axis.
    ///   - length: The length of the axis.
    ///   - unitSize: The distance between each tick of the line. Overwritten by `length`, if specified.
    ///   - include: The set to include on graph.
    ///   - strokeWidth: The thickness of the line.
    ///   - scaling: The way the `range` is value is scaled.
    public init(
        range: Range? = nil,
        length: Double? = nil,
        unitSize: Double = 1,
        include: DisplayStyle = [],
        strokeWidth: Double? = nil,
        scaling: ScaleBase = .linear(),
        from start: Point? = nil, to end: Point? = nil
    ) {
        var args: Closure.Arguments = [
            ("x_range", range),
            ("length", length),
            ("unit_size", unitSize),
            ("stroke_width", strokeWidth),
            ("scaling", scaling),
            ("start", start), ("end", end)
        ]
        if !include.contains(.ticks)  { args.append("include_ticks",  false) }
        if include.contains(.numbers) { args.append("include_numbers", true) }
        if include.contains(.tip)     { args.append("include_tip",     true) }
        
        super.init(manim.NumberLine.dynamicallyCall(withKeywordArguments: args))
    }
    
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    
    @MainActor
    public struct DisplayStyle: @MainActor OptionSet {
        
        public var rawValue: UInt8
        
        /// Whether to include ticks on the number line.
        public static let ticks = DisplayStyle(rawValue: 1 << 0)
        
        /// Whether to add numbers to the tick marks. The number of decimal places is determined by the step size
        public static let numbers  = DisplayStyle(rawValue: 1 << 1)
        
        /// Whether to include tip.
        public static let tip  = DisplayStyle(rawValue: 1 << 2)
        
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
    }
    
    @MainActor
    public enum ScaleBase: @MainActor PythonConvertible {
        case linear(scale: Double = 1)
        case log(base: Double = 10)
        
        public var pythonObject: PythonObject {
            switch self {
            case .linear(let scale):
                manim.LinearBase(scale_factor: scale)
            case .log(let base):
                manim.LogBase(base: base)
            }
        }
    }
    
}
