//
//  DecimalNumber.swift
//  Manim
//
//  Created by Vaida on 2025-09-27.
//

import Foundation
import PythonKit


/// An object representing a decimal number.
///
/// ```swift
/// @ValueTracker var value = 0.0
/// let number = DecimalNumber($value, format: .precision(fractionLength: 4))
/// let dot = Dot()
/// let numberLine = NumberLine(range: Range(0...4))
/// scene.add(VStack(numberLine, number), dot)
///
/// dot.addUpdater {
///     dot.move(to: numberLine.convert(number: value))
/// }
/// withAnimation {
///     $value.become(.pi)
/// }
///
/// scene.sleep()
/// withAnimation {
///     $value.become(0)
/// }
/// ```
///
/// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/DecimalNumber.mov)
public class DecimalNumber: SVGMObject {
    
    /// Creates a number
    ///
    /// - Parameters:
    ///   - number: The numeric value to be displayed.
    ///   - format: The format used to format `number`.
    ///   - unit: A unit string which can be placed to the right of the numerical values.
    ///   - fontSize: Size of the font.
    ///   - color: The color of the text.
    public init(_ number: Double, format: Format? = nil, unit: String? = nil, fontSize: Double = 48, color: Color = .white) {
        var arguments = Closure.Arguments()
        arguments.append("number", number)
        arguments.append("num_decimal_places", format?.fractionLength ?? 2)
        arguments.append("include_sign", format?.signStrategy != .automatic)
        arguments.append("group_with_commas", format?.decimalSeparator ?? false)
        arguments.append("unit", unit)
        arguments.append("font_size", fontSize)
        arguments.append("fill_color", color)
        arguments.append("fill_opacity", color.alpha)
        
        super.init(_pythonObject: manim.DecimalNumber.dynamicallyCall(withKeywordArguments: arguments))
    }
    
    /// Creates a number display & updates from the `ValueTracker` automatically.
    ///
    /// - Parameters:
    ///   - number: The numeric value to be displayed.
    ///   - format: The format used to format `number`.
    ///   - unit: A unit string which can be placed to the right of the numerical values.
    ///   - fontSize: Size of the font.
    ///   - color: The color of the text.
    public convenience init(_ number: Projection<Double>, format: Format? = nil, unit: String? = nil, fontSize: Double = 48, color: Color = .white) {
        self.init(number.wrappedValue, format: format, unit: unit, fontSize: fontSize, color: color)
        self.addUpdater { self.number = number.wrappedValue }
    }
    
    /// The wrapped value
    public var number: Double {
        get { Double(self._pythonObject.get_value())! }
        set { self._pythonObject.set_value(newValue) }
    }
    
    
    /// Decimal Number display format
    public struct Format {
        
        let fractionLength: Int
        
        let signStrategy: SignStrategy
        
        let decimalSeparator: Bool
        
        
        /// Modifies the format style to use a precision that constrains formatted values to a given number of allowed digits in the fraction part.
        public func precision(fractionLength: Int) -> Format {
            Format(fractionLength: fractionLength, signStrategy: signStrategy, decimalSeparator: decimalSeparator)
        }
        
        /// Modifies the format style to use the specified sign display strategy for displaying or omitting sign symbols.
        public func sign(strategy: SignStrategy) -> Format {
            Format(fractionLength: fractionLength, signStrategy: strategy, decimalSeparator: decimalSeparator)
        }
        
        /// Modifies the format style to use the specified decimal separator display strategy.
        public func decimalSeparator(_ bool: Bool = true) -> Format {
            Format(fractionLength: fractionLength, signStrategy: signStrategy, decimalSeparator: bool)
        }
        
        
        /// Returns a precision that constrains formatted values to a given number of allowed digits in the fraction part.
        public static func precision(fractionLength: Int) -> Format {
            Format(fractionLength: fractionLength)
        }
        
        /// The format style to use the specified sign display strategy for displaying or omitting sign symbols.
        public static func sign(strategy: SignStrategy) -> Format {
            Format(signStrategy: strategy)
        }
        
        /// The format style to use the specified decimal separator display strategy.
        public static func decimalSeparator(_ bool: Bool = true) -> Format {
            Format(decimalSeparator: bool)
        }
        
        
        init(fractionLength: Int = 2, signStrategy: SignStrategy = .automatic, decimalSeparator: Bool = false) {
            self.fractionLength = fractionLength
            self.signStrategy = signStrategy
            self.decimalSeparator = decimalSeparator
        }
        
        
        /// A structure that format style uses to configure a sign display strategy.
        public enum SignStrategy {
            
            /// Show sign only for negative values.
            case automatic
            
            /// A strategy to always display sign symbols.
            ///
            /// Include a sign for positive numbers and zero.
            case always
        }
        
    }
    
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
