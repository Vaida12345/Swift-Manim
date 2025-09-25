//
//  MObject + Children.swift
//  Manim
//
//  Created by Vaida on 2025-09-23.
//


extension MObject {
    
    /// The contained objects
    public var children: [MObject] {
        self.pythonObject.submobjects.map({ MObject($0) })
    }
    
}
