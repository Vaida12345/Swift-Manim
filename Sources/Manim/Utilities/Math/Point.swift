//
//  Point.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//




/// An object that is a point, or a method with return value of point.
public protocol PointLike {
    
    var pyDescription: String { get }
    
}


extension PointLike where Self == Point {
    
    public static var center: Point { Point() }
    
}


/// A point, with the center being (0, 0, 0).
public class Point: PyObject, PointLike {
   
    let x: Double
    
    let y: Double
    
    let z: Double
    
    
    public func shift(_ value: Double, to direction: Direction) -> Point {
        self + value * direction._point
    }
    
    
    public init(x: Double = 0, y: Double = 0, z: Double = 0) {
        self.x = x
        self.y = y
        self.z = z
        
        super.init(identifier: __formVariableName(base: "\(Self.self)"))
    }
    
    required init(identifier: String) {
        self.x = 0
        self.y = 0
        self.z = 0
        
        super.init(identifier: identifier)
    }
    
    static func * (lhs: Double, rhs: Point) -> Point {
        Point(x: lhs * rhs.x,
              y: lhs * rhs.y,
              z: lhs * rhs.z)
    }
    
    static func + (lhs: Point, rhs: Point) -> Point {
        Point(x: lhs.x + rhs.x,
              y: lhs.y + rhs.y,
              z: lhs.z + rhs.z)
    }
    
    static func - (lhs: Point, rhs: Point) -> Point {
        Point(x: lhs.x - rhs.x,
              y: lhs.y - rhs.y,
              z: lhs.z - rhs.z)
    }
    
    public var pyDescription: String {
        "array([\(self.x), \(self.y), \(self.z)])"
    }
}


extension Array: PointLike where Element == Int {
    
    public var pyDescription: String {
        "array(\(self.description))"
    }
    
}


extension Method: PointLike where ReturnValue == Point {
    public var pyDescription: String {
        self.get()
    }
}
