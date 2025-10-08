//
//  Point.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import PythonKit


/// A point in 2D / 3D plane.
///
/// You can use an array to represent a point
/// ```swift
/// let point: Point = [2, 2]
/// ```
@MainActor
public struct Point: @MainActor ExpressibleByArrayLiteral, @MainActor PythonConvertible, @MainActor ConvertibleFromPython, @MainActor CustomStringConvertible {
    
    public let x: Double
    
    public let y: Double
    
    public let z: Double
    
    
    /// A description for a point that is suitable for displaying to user using ``Text``.
    public var description: String {
        var description = "(\(x.userFriendlyDescription), \(y.userFriendlyDescription)"
        if z != 0 {
            description += ", \(z.userFriendlyDescription))"
        }
        return description + ")"
    }
    
    
    /// Shifts the point by a given distance along a specified direction.
    ///
    /// - Parameters:
    ///   - value: The distance to move the point.
    ///   - direction: The `Direction` in which to shift the point.
    ///
    /// - Returns: A new `Point` translated from the original by `value` units toward `direction`.
    public func shift(_ value: Double, to direction: Direction) -> Point {
        self + value * Point(direction)
    }
    
    public var pythonObject: PythonObject {
        numpy.array([self.x, self.y, self.z])
    }
    
    /// Returns a point located at the center of the screen.
    public static var center: Point {
        Point(x: 0, y: 0)
    }
    
    /// The point at (0, 0).
    public static var zero: Point {
        Point(x: 0, y: 0)
    }
    
    public init?(_ object: PythonKit.PythonObject) {
        guard let array = Array<Double>(object) else { return nil }
        self.init(array)
    }
    
    public init(x: Double, y: Double, z: Double = 0) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    init(_ direction: Direction) {
        self.init(direction.pythonObject)!
    }
    
    public init(arrayLiteral elements: Double...) {
        self.init(elements)
    }
    
    public init(_ elements: [Double]) {
        if elements.count == 2 {
            self.init(x: elements[0], y: elements[1])
        } else if elements.count == 3 {
            self.init(x: elements[0], y: elements[1], z: elements[2])
        } else if elements.isEmpty {
            self.init(x: 0, y: 0)
        } else {
            fatalError("Not enough arguments to unpack for Point")
        }
    }
    
    
    public static func * (lhs: Double, rhs: Point) -> Point {
        Point(x: lhs * rhs.x,
              y: lhs * rhs.y,
              z: lhs * rhs.z)
    }
    
    public static func + (lhs: Point, rhs: Point) -> Point {
        Point(x: lhs.x + rhs.x,
              y: lhs.y + rhs.y,
              z: lhs.z + rhs.z)
    }
    
    public static func - (lhs: Point, rhs: Point) -> Point {
        Point(x: lhs.x - rhs.x,
              y: lhs.y - rhs.y,
              z: lhs.z - rhs.z)
    }
}


extension Projection<Point> {
    
    public static func * (lhs: Double, rhs: Projection<Point>) -> Projection<Point> {
        Projection {
            lhs * rhs.wrappedValue
        }
    }
    
    public static func + (lhs: Projection<Point>, rhs: @autoclosure @escaping () -> Point) -> Projection<Point> {
        Projection {
            lhs.wrappedValue + rhs()
        }
    }
    
}
