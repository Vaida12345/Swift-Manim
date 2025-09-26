//
//  Color.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import PythonKit


/// A representation of a color
@MainActor
public struct Color: Equatable, @MainActor PythonConvertible, @MainActor ConvertibleFromPython, @MainActor CustomStringConvertible {
    
    let box: Box
    
    /// A human-readable description of the color.
    public var description: String {
        switch box {
        case .predefined(let string):
            return "Color.\(string)"
        case .hex(let string, let alpha):
            var string = "Color(\(string.uppercased())"
            if alpha != 1 {
                string += ", alpha: \(alpha)"
            }
            string += ")"
            return string
        case .rgba(let r, let g, let b, let a):
            return "Color(\(r, format: .percent.precision(0)), \(g, format: .percent.precision(0)), \(b, format: .percent.precision(0)), \(a, format: .percent.precision(0)))"
        }
    }
    
    /// The opacity (alpha channel) of this color, from 0 (fully transparent) to 1 (fully opaque).
    public var alpha: Double {
        switch self.box {
        case .predefined: 1
        case .hex(_, let alpha): alpha
        case .rgba(_, _, _, let a): a
        }
    }
    
    /// Returns a new Color with the same base hue but the specified opacity.
    ///
    /// - Parameter opacity: A value between 0 and 1 representing the desired alpha component.
    ///
    /// - Returns: A copy of this color with its alpha set to `opacity`.
    public func opacity(_ opacity: Double) -> Color {
        switch self.box {
        case .predefined(let string):
            let rgba = manim.ManimColor.parse(string).to_rgba()
            let array = Array<Double>(rgba)!
            return Color(box: .rgba(array[0], array[1], array[2], opacity))
        case .hex(let string, _):
            return Color(box: .hex(string, alpha: opacity))
        case .rgba(let r, let g, let b, _):
            return Color(box: .rgba(r, g, b, opacity))
        }
    }
    
    enum Box: Equatable {
        case predefined(String)
        case hex(String, alpha: Double)
        case rgba(Double, Double, Double, Double)
    }
    
    public static let blue = Color(box: .predefined("blue"))
    public static let teal = Color(box: .predefined("teal"))
    public static let green = Color(box: .predefined("green"))
    public static let yellow = Color(box: .predefined("yellow"))
    public static let gold = Color(box: .predefined("gold"))
    public static let red = Color(box: .predefined("red"))
    public static let maroon = Color(box: .predefined("maroon"))
    public static let purple = Color(box: .predefined("purple"))
    public static let pink = Color(box: .predefined("pink"))
    public static let orange = Color(box: .predefined("orange"))
    public static let white = Color(box: .predefined("white"))
    public static let gray = Color(box: .predefined("gray"))
    public static let black = Color(box: .predefined("black"))
    
    /// A fully transparent (clear) color, equivalent to white with zero alpha.
    public static let clear = Color(box: .rgba(1, 1, 1, 0))
    
    /// All available predefined color constants, in no particular order.
    public static let predefinedColors: [Color] = [
        blue, teal, green, yellow, gold, red, maroon, purple, pink, orange, white, gray, black
    ]
        
    /// Creates a color from a hexadecimal string.
    ///
    /// - Parameters:
    ///   - hex: A hex code string, with or without a leading “#”, e.g. “FF00FF” or “#FF00FF”.
    ///   - alpha: An optional alpha component from 0 to 1 (default is 1).
    /// - Returns: A new Color representing the given hex code and opacity.
    public static func hex(_ hex: String, alpha: Double = 1) -> Color {
        Color(box: .hex(hex, alpha: alpha))
    }
    
    /// Creates a color from individual red, green, blue, and optional alpha components.
    ///
    /// - Parameters:
    ///   - r: Red channel, from 0 to 1.
    ///   - g: Green channel, from 0 to 1.
    ///   - b: Blue channel, from 0 to 1.
    ///   - a: Alpha channel, from 0 to 1 (default is 1).
    ///
    /// - Returns: A new Color with the specified RGBA values.
    public static func rgba(_ r: Double, _ g: Double, _ b: Double, _ a: Double = 1) -> Color {
        Color(box: .rgba(r, g, b, a))
    }
    
    init(box: Box) {
        self.box = box
    }
    
    /// Initializes a Color by parsing a hex string.
    ///
    /// - Parameters:
    ///   - hex: A hex code string, e.g. “FF0000” or “#FF0000”.
    ///   - alpha: An optional alpha component (default is 1).
    public init(_ hex: String, alpha: Double = 1) {
        self.box = .hex(hex, alpha: alpha)
    }
    
    /// Initializes a grayscale color with the specified white intensity and opacity.
    ///
    /// - Parameters:
    ///   - white: A grayscale intensity value from 0.0 (black) to 1.0 (white).
    ///   - alpha: The opacity level of the color, where 0.0 is fully transparent and 1.0 is fully opaque. Defaults to 1.0.
    public init(white: Double, alpha: Double = 1) {
        self.box = .rgba(white, white, white, alpha)
    }
    
    public init?(_ object: PythonObject) {
        for color in Color.predefinedColors {
            if object == manim.ManimColor.parse(color) {
                self = color
                return
            }
        }
        
        let rgba = object.to_rgba()
        guard rgba.count == 4 else { return nil }
        guard let array = Array<Double>(rgba) else { return nil }
        self.box = .rgba(array[0], array[1], array[2], array[3])
    }
    
    
    public var pythonObject: PythonObject {
        switch self.box {
        case .predefined(let string):
            string.uppercased().pythonObject
        case .hex(let string, let alpha):
            manim.ManimColor.from_hex(string.uppercased(), alpha: alpha)
        case let .rgba(r, g, b, a):
            manim.ManimColor.from_rgba([r, g, b, a])
        }
    }
}
