//
//  NumberLine.swift
//
//
//  Created by Vaida on 2023/10/17.
//


/// Creates a number line with tick marks.
public final class NumberLine: Line {
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    /// Creates a number line with tick marks.
    ///
    /// - Parameters:
    ///   - domain: The
    ///   - length: The length of the axis.
    ///   - unitSize: The distance between each tick of the line. Overwritten by `length`, if specified.
    ///   - includeTicks: Whether to include ticks on the number line.
    ///   - width: The thickness of the line.
    ///   - includeTips: Whether or not to include the tip on axis.
    ///   - tip: The properties of the tip.
    public init(domain: Range? = nil,
                length: Double? = nil,
                unitSize: Double = 1,
                include: DisplayStyle = [],
                width: Double? = nil,
                tip: TipStyle? = nil
                ) {
//        includeTip: Bool = true,
    }
    
    
    public struct Range: ExpressibleByFloatLiteral {
        
        let min: Double
        
        let max: Double
        
        let step: Double
        
        
        /// Creates an range given its `(min, max, step)` values of the axis.
        public init(min: Double = 0, max: Double, step: Double = 1) {
            self.min = min
            self.max = max
            self.step = step
        }
        
        /// Creates an range given its `max` value.
        public init(floatLiteral value: Double) {
            self.init(max: value)
        }
    }
    
    public struct TipStyle {
        
        let width: Double?
        
        let height: Double?
        
        let shape: (any ArrowTipShape)?
        
        /// Creates a tip style.
        public init(width: Double? = nil, height: Double? = nil, shape: (any ArrowTipShape)? = nil) {
            self.width = width
            self.height = height
            self.shape = shape
        }
    }
    
    public struct DisplayStyle: OptionSet {
        
        public var rawValue: UInt8
        
        /// Whether to include ticks on the number line.
        public static let ticks = DisplayStyle(rawValue: 1 << 0)
        
        /// Whether to add numbers to the tick marks. The number of decimal places is determined by the step size
        public static let numbers  = DisplayStyle(rawValue: 1 << 1)
        
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
    }
    
    public enum ScaleBase: String {
        case linear
        case log
    }
    
}
