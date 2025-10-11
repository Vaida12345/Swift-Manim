//
//  Axis.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import PythonKit


/// An `OptionSet` representing one or more principal axes in 3D space.
/// 
/// Use this type to specify the x-, y-, and z-axes individually or in combination:
///   - `.x` selects the x-axis
///   - `.y` selects the y-axis
///   - `.z` selects the z-axis
///   - `.all` selects all three axes at once
@MainActor
public struct Axis: @MainActor OptionSet, @MainActor PythonConvertible, @MainActor CustomStringConvertible {
    
    public let rawValue: UInt8
    
    public static let x = Axis(rawValue: 1 << 0)
    public static let y = Axis(rawValue: 1 << 1)
    public static let z = Axis(rawValue: 1 << 2)
    
    public static let all: Axis = [.x, .y, .z]
    
    
    public var description: String {
        switch self {
        case .x: ".x"
        case .y: ".y"
        case .z: ".z"
        case .all: ".all"
        default: [self.contains(.x) ? 1 : 0, self.contains(.y) ? 1 : 0, self.contains(.z) ? 1 : 0].description
        }
    }
    
    
    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
    
    public var pythonObject: PythonObject {
        numpy.array([self.contains(.x) ? 1 : 0, self.contains(.y) ? 1 : 0, self.contains(.z) ? 1 : 0])
    }
    
}
