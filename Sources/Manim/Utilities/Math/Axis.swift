//
//  Axis.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import PythonKit


/// The axis.
@MainActor
public struct Axis: @MainActor OptionSet, @MainActor PythonConvertible {
    
    public let rawValue: UInt8
    
    public static let x = Axis(rawValue: 1 << 0)
    public static let y = Axis(rawValue: 1 << 1)
    public static let z = Axis(rawValue: 1 << 2)
    
    public static let all: Axis = [.x, .y, .z]
    
    
    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
    
    public var pythonObject: PythonObject {
        numpy.array([self.contains(.x) ? 1 : 0, self.contains(.y) ? 1 : 0, self.contains(.z) ? 1 : 0])
    }
    
}
