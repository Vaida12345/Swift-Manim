//
//  Color.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import PythonKit


/// A preset of colors.
@MainActor
public struct Color: Equatable, @MainActor PythonConvertible, @MainActor ConvertibleFromPython, @MainActor CustomStringConvertible {
    
    let box: Box
    
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
    
    public var alpha: Double {
        switch self.box {
        case .predefined: 1
        case .hex(_, let alpha): alpha
        case .rgba(_, _, _, let a): a
        }
    }
    
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
    public static let clear = Color(box: .rgba(1, 1, 1, 0))
    
    public static let predefinedColors: [Color] = [
        blue, teal, green, yellow, gold, red, maroon, purple, pink, orange, white, gray, black
    ]
    
    public static func hex(_ hex: String, alpha: Double = 1) -> Color {
        Color(box: .hex(hex, alpha: alpha))
    }
    
    public static func rgba(_ r: Double, _ g: Double, _ b: Double, _ a: Double = 1) -> Color {
        Color(box: .rgba(r, g, b, a))
    }
    
    init(box: Box) {
        self.box = box
    }
    
    public init(_ hex: String, alpha: Double = 1) {
        self.box = .hex(hex, alpha: alpha)
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
