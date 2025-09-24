//
//  Point.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import PythonKit


/// A point, with the center being (0, 0, 0).
public struct Point: @MainActor ExpressibleByArrayLiteral, @MainActor PythonConvertible, @MainActor ConvertibleFromPython {
    
    public let x: Double
    
    public let y: Double
    
    public let z: Double
    
    
    public func shift(_ value: Double, to direction: Direction) -> Point {
        self + value * Point(direction)
    }
    
    public var pythonObject: PythonObject {
        [self.x, self.y, self.z].pythonObject
    }
    
    public static var center: Point {
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
        switch direction {
        case .left:
            self = [-1, 0]
        case .right:
            self = [1, 0]
        case .up:
            self =  [0, 1]
        case .down:
            self = [0, -1]
        }
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
