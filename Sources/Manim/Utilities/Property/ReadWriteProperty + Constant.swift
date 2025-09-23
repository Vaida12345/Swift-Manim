//
//  ReadWrite + Constant.swift
//  Manim
//
//  Created by Vaida on 2025-09-19.
//


extension ReadWriteProperty {
    
    /// Creates a constant.
    ///
    /// A constant serves as a shorthand to assign values.
    ///
    /// - Warning: You should never modify a constant.
    public static func constant(_ constant: Value) -> ReadWriteProperty<Value> {
        ReadWriteProperty(constant: constant)
    }
    
}

extension ReadWriteProperty: @MainActor ExpressibleByFloatLiteral where Value == Double {
    
    public convenience init(floatLiteral value: Double) {
        self.init(constant: value)
    }
}


extension ReadWriteProperty: @MainActor ExpressibleByIntegerLiteral where Value == Int {
    
    public convenience init(integerLiteral value: Int) {
        self.init(constant: value)
    }
    
}

extension ReadWriteProperty<Point> {
    
    public static let center = ReadWriteProperty(constant: Point.center)
    
}

extension ReadWriteProperty<Point>: @MainActor ExpressibleByArrayLiteral {
    
    public convenience init(arrayLiteral elements: Double...) {
        self.init(constant: Point(elements))
    }
    
}


extension ReadWriteProperty<Color> {
    
    public static let blue = ReadWriteProperty<Color>(constant: .blue)
    public static let teal = ReadWriteProperty<Color>(constant: .teal)
    public static let green = ReadWriteProperty<Color>(constant: .green)
    public static let yellow = ReadWriteProperty<Color>(constant: .yellow)
    public static let gold = ReadWriteProperty<Color>(constant: .gold)
    public static let red = ReadWriteProperty<Color>(constant: .red)
    public static let maroon = ReadWriteProperty<Color>(constant: .maroon)
    public static let purple = ReadWriteProperty<Color>(constant: .purple)
    public static let pink = ReadWriteProperty<Color>(constant: .pink)
    public static let orange = ReadWriteProperty<Color>(constant: .orange)
    public static let white = ReadWriteProperty<Color>(constant: .white)
    public static let gray = ReadWriteProperty<Color>(constant: .gray)
    public static let black = ReadWriteProperty<Color>(constant: .black)
    
}
