//
//  Point.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//


public protocol PointProtocol: PythonScriptConvertible {
    
}


extension PointProtocol where Self == Point {
    
    public static var center: Point {
        Point(x: 0, y: 0)
    }
    
}


extension Array<Double>: PythonScriptConvertible {
    
    public var representation: String {
        if self.count == 2 {
            Point(x: self[0], y: self[1]).representation
        } else if self.count == 3 {
            Point(x: self[0], y: self[1], z: self[2]).representation
        } else {
            fatalError("Not enough arguments for Point")
        }
    }
    
}

extension Array<Double>: PointProtocol {
    
    
    
}


/// A point, with the center being (0, 0, 0).
public class Point: PyObject, PointProtocol, ExpressibleByArrayLiteral {
   
    public let x: Double
    
    public let y: Double
    
    public let z: Double
    
    
    public func shift(_ value: Double, to direction: Direction) -> Point {
        self + value * direction._point
    }
    
    
    public init(x: Double, y: Double, z: Double = 0) {
        self.x = x
        self.y = y
        self.z = z
        
        super.init(identifier: __formVariableName(base: "\(Self.self)"))
    }
    
    required public convenience init(arrayLiteral elements: Double...) {
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
    
    required init(identifier: String) {
        fatalError("init(identifier:) has not been implemented")
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
    
    public override var representation: String {
        "array([\(self.x), \(self.y), \(self.z)])"
    }
}
