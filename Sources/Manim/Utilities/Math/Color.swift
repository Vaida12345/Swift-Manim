//
//  Color.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//


/// A preset of colors.
public enum Color: String, PythonScriptConvertible {
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
    
    case clear
    
    public var representation: String {
        self.rawValue.uppercased()
    }
}
