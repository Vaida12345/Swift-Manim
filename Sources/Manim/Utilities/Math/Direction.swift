//
//  Position.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import PythonKit


public enum Direction: String, Equatable, PythonConvertible {
    case left
    case right
    case up
    case down
    
    public var pythonObject: PythonObject {
        self.rawValue.uppercased().pythonObject
    }
}
