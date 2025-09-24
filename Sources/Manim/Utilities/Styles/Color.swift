//
//  Color.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import PythonKit


/// A preset of colors.
public enum Color: String, @MainActor PythonConvertible {
    case blue
    case teal
    case green
    case yellow
    case gold
    case red
    case maroon
    case purple
    
    case pink
    case orange
    
    case white
    case gray
    case black
    
    
    public var pythonObject: PythonObject {
        self.rawValue.uppercased().pythonObject
    }
}
