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
            Point(x: -1)
        case .right:
            Point(x: 1)
        case .up:
            Point(y: 1)
        case .down:
            Point(y: -1)
        }
    }
}
