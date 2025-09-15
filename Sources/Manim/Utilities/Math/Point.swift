//
//  Point.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//




/// An object that is a point, or a method with return value of point.
public protocol PointProtocol {
    
    var pyDescription: String { get }
    
}


extension PointProtocol where Self == Point {
    
    /// The center of the canvas, `(0, 0, 0)`.
    public static var center: Point { Point() }
    
}


/// A point, with the center being (0, 0, 0).
public class Point: PyObject, PointProtocol, ExpressibleByArrayLiteral {
   
    let x: Double
    
    let y: Double
    
    let z: Double
    
    
    public func shift(_ value: Double, to direction: Direction) -> Point {
        self + value * direction._point
    }
    
    
    public init(x: Double, y: Double, z: Double = 0) {
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
    
    public required convenience init(arrayLiteral elements: Double...) {
        if elements.count == 2 {
            self.init(x: elements[0], y: elements[1])
        } else if elements.count == 3 {
            self.init(x: elements[0], y: elements[1], z: elements[2])
        } else if elements.isEmpty {
            self.init(x: 0, y: 0)
        } else {
            fatalError("Not enough arguments for Point")
        }
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


extension Array: PointProtocol where Element == Int {
    
    public var pyDescription: String {
        precondition(self.count >= 0 && self.count <= 3)
        
        let additional = [Int](repeating: 0, count: 3 - self.count)
        return "array(\((self + additional)))"
    }
    
}


extension Method: PointProtocol where ReturnValue == Point {
    public var pyDescription: String {
        self.get()
    }
}
