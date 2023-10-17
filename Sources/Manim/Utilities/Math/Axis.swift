//
//  Axis.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//




/// The axis.
public struct Axis: OptionSet {
    
    public let rawValue: UInt8
    
    public static let x = Axis(rawValue: 1 << 0)
    public static let y = Axis(rawValue: 1 << 1)
    public static let z = Axis(rawValue: 1 << 2)
    
    public static let all: Axis = [.x, .y, .z]
    
    
    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
    
    var pyDescription: String {
        "array([\(self.contains(.x) ? 1 : 0), \(self.contains(.y) ? 1 : 0), \(self.contains(.z) ? 1 : 0)])"
    }
    
}
