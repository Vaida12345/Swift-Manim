//
//  MObject + Children.swift
//  Manim
//
//  Created by Vaida on 2025-09-23.
//


extension MObject {
    
    public var children: Children {
        Children(base: self)
    }
    
    
    @MainActor
    public struct Children {
        
        let base: MObject
        
        public subscript(index: Int) -> MObject {
            MObject(identifier: "\(base.representation).submobjects[\(index)]")
        }
        
    }
    
}
