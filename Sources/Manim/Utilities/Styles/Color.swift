//
//  Color.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import PythonKit


/// A preset of colors.
@MainActor
public struct Color: Equatable, @MainActor PythonConvertible, @MainActor ConvertibleFromPython {
    
    let box: Box
    
    enum Box: Equatable {
        case predefined(String)
        case hex(String, alpha: Double)
        case rgba(Double, Double, Double, Double)
    }
    
    public static let blue = Color(box: .predefined("blue".uppercased()))
    public static let teal = Color(box: .predefined("teal".uppercased()))
    public static let green = Color(box: .predefined("green".uppercased()))
    public static let yellow = Color(box: .predefined("yellow".uppercased()))
    public static let gold = Color(box: .predefined("gold".uppercased()))
    public static let red = Color(box: .predefined("red".uppercased()))
    public static let maroon = Color(box: .predefined("maroon".uppercased()))
    public static let purple = Color(box: .predefined("purple".uppercased()))
    public static let pink = Color(box: .predefined("pink".uppercased()))
    public static let orange = Color(box: .predefined("orange".uppercased()))
    public static let white = Color(box: .predefined("white".uppercased()))
    public static let gray = Color(box: .predefined("gray".uppercased()))
    public static let black = Color(box: .predefined("black".uppercased()))
    
    public static func hex(_ hex: String, alpha: Double = 1) -> Color {
        Color(box: .hex(hex, alpha: alpha))
    }
    
    public static func rgba(_ r: Double, _ g: Double, _ b: Double, _ a: Double = 1) -> Color {
        Color(box: .rgba(r, g, b, a))
    }
    
    init(box: Box) {
        self.box = box
    }
    
    public init?(_ object: PythonObject) {
        let rgba = object.to_rgba()
        guard rgba.count == 4 else { return nil }
        guard let array = Array<Double>(rgba) else { return nil }
        self.box = .rgba(array[0], array[1], array[2], array[3])
    }
    
    
    public var pythonObject: PythonObject {
        switch self.box {
        case .predefined(let string):
            string.pythonObject
        case .hex(let string, let alpha):
            manim.ManimColor.from_hex(string, alpha: alpha)
        case let .rgba(r, g, b, a):
            manim.ManimColor.from_rgba([r, g, b, a])
        }
    }
}
