//
//  Position.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import Foundation
import PythonKit


/// Primary compass directions in a 2D plane.
@MainActor
public struct Direction: Equatable, @MainActor PythonConvertible, @MainActor ConvertibleFromPython {
    
    public let pythonObject: PythonObject
    
    public static let left = Direction(pythonObject: manim.LEFT)
    public static let right = Direction(pythonObject: manim.RIGHT)
    public static let top = Direction(pythonObject: manim.UP)
    public static let up = Direction.top
    public static let bottom = Direction(pythonObject: manim.DOWN)
    public static let down = Direction.bottom
    
    public static let topLeft = Direction(pythonObject: manim.UL)
    public static let topRight = Direction(pythonObject: manim.UR)
    public static let bottomLeft = Direction(pythonObject: manim.DL)
    public static let bottomRight = Direction(pythonObject: manim.DR)
    
    init(pythonObject: PythonObject) {
        self.pythonObject = pythonObject
    }
    
    public init?(_ object: PythonObject) {
        self.pythonObject = object
    }
    
    /// Creates a direction by normalizing a point to a unit vector.
    public init(_ point: Point) {
        self.pythonObject = manim.normalize(point)
    }
    
    /// Creates a direction using the given gradient
    public init(gradient: Double) {
        let magnitude = sqrt(1 + gradient * gradient)
        self.init(Point(x: 1 / magnitude, y: gradient / magnitude))
    }
    
    /// Creates a direction using the given angle with the x-axis.
    public init(angle: Angle) {
        self.init(Point(x: cos(angle.radians), y: sin(angle.radians)))
    }
    
    /// Creates a direction using the given gradient
    public static func gradient(_ gradient: Double) -> Direction {
        Direction(gradient: gradient)
    }
    
    /// Creates a direction using the given angle with the x-axis.
    public static func angle(_ angle: Angle) -> Direction {
        Direction(angle: angle)
    }
}
