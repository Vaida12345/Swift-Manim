//
//  NumberLine.swift
//
//
//  Created by Vaida on 2023/10/17.
//

import PythonKit


/// Creates a number line with tick marks.
///
/// ```swift
/// let numberLine = NumberLine(
///     range: Range(1...4),
///     include: [.numbers, .tip, .ticks]
/// )
/// ```
///
/// ![Preview](NumberLine)
public final class NumberLine: Line {
    
    /// Creates a number line with tick marks.
    ///
    /// - Parameters:
    ///   - range: The range of the axis.
    ///   - include: The set to include on graph.
    ///   - width: The thickness of the line.
    ///   - scaling: The way the `range` is value is scaled.
    public init(
        range: Range? = nil,
        width: Double = 2,
        include: DisplayStyle = [.tip, .ticks],
        scaling: ScaleBase = .linear()
    ) {
        var args: Closure.Arguments = [
            ("x_range", range?._adjustForTip(hasTip: include.contains(.tip))),
            ("stroke_width", width),
            ("scaling", scaling)
        ]
        args.append("include_ticks",  include.contains(.ticks))
        args.append("include_numbers", include.contains(.numbers))
        args.append("include_tip",     include.contains(.tip))
        
        super.init(manim.NumberLine.dynamicallyCall(withKeywordArguments: args))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
    
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


extension NumberLine {
    
    /// Returns a float along the number line.
    ///
    /// - Parameters:
    ///   - point: A point with respect to the scene.
    ///
    /// - Returns: A float representing a value along the number line.
    public func convert(point: Point) -> Double {
        Double(self.pythonObject.point_to_number(point))!
    }
    
    /// Returns a point with respect to the scene.
    ///
    /// - Parameters:
    ///   - number: The value to be transformed into a coordinate.
    ///
    /// - Returns: A point with respect to the scene’s coordinate system.
    public func convert(number: Double) -> Point {
        Point(self.pythonObject.number_to_point(number))!
    }
    
}


extension NumberLine {
    
    /// Returns a float along the number line.
    ///
    /// - Parameters:
    ///   - point: A point with respect to the scene.
    ///
    /// - Returns: A float representing a value along the number line.
    public func convert(point: Binding<Point>) -> Binding<Double> {
        Binding {
            self.convert(point: point.wrappedValue)
        } set: { newValue in
            point.wrappedValue = self.convert(number: newValue)
        }
    }
    
    /// Returns a point with respect to the scene.
    ///
    /// - Parameters:
    ///   - number: The value to be transformed into a coordinate.
    ///
    /// - Returns: A point with respect to the scene’s coordinate system.
    public func convert(number: Binding<Double>) -> Binding<Point> {
        Binding {
            self.convert(number: number.wrappedValue)
        } set: { newValue in
            number.wrappedValue = self.convert(point: newValue)
        }
    }
    
}
