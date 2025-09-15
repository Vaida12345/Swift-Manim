//
//  Position.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//


public enum Direction: String, Equatable {
    case left
    case right
    case up
    case down
    
    var pyDescription: String {
        self.rawValue.uppercased()
    }
    
    var _point: Point {
        switch self {
        case .left:
            [-1, 0]
        case .right:
            [1, 0]
        case .up:
            [0, 1]
        case .down:
            [0, -1]
        }
    }
}
