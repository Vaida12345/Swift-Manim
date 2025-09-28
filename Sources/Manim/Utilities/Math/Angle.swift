//
//  Angle.swift
//  Manim
//
//  Created by Vaida on 2025-09-28.
//

import PythonKit


/// A geometric angle whose value you access in either radians or degrees.
///
/// When `Angle` is `0`, the line an arrow from `(0, 0)` to `(1, 0)`.
@MainActor
public struct Angle: @MainActor PythonConvertible, @MainActor ConvertibleFromPython, @MainActor CustomStringConvertible {
    
    public var radians: Double
    
    public var degrees: Double {
        get { 180 / Double.pi * radians }
        set { self.radians = newValue * .pi / 180 }
    }
    
    public init(radians: Double) {
        self.radians = radians
    }
    
    public init(degrees: Double) {
        self.radians = degrees * Double.pi / 180
    }
    
    
    public static let zero = Angle(radians: 0)
    
    public static func degrees(_ degrees: Double) -> Angle {
        Angle(degrees: degrees)
    }
    
    public static func radians(_ radians: Double) -> Angle {
        Angle(radians: radians)
    }
    
    public static func + (lhs: Angle, rhs: Angle) -> Angle {
        Angle(radians: lhs.radians + rhs.radians)
    }
    
    public static func - (lhs: Angle, rhs: Angle) -> Angle {
        Angle(radians: lhs.radians - rhs.radians)
    }
    
    
    public var pythonObject: PythonObject {
        self.radians.pythonObject
    }
    
    public init?(_ object: PythonObject) {
        guard let double = Double(object) else { return nil }
        self.init(radians: double)
    }
    
    public var description: String {
        ".degree(\(self.degrees.userFriendlyDescription))"
    }
}


extension Projection<Angle> {
    
    public static func degrees(_ degrees: Projection<Double>) -> Projection<Angle> {
        Projection {
            Angle(degrees: degrees.wrappedValue)
        }
    }
    
    public static func radians(_ radians: Projection<Double>) -> Projection<Angle> {
        Projection {
            Angle(radians: radians.wrappedValue)
        }
    }
    
}
