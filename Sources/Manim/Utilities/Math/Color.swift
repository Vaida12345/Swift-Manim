//
//  Color.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//




public enum Color: String {
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
    
    internal var pyDescription: String {
        self.rawValue.uppercased()
    }
}
