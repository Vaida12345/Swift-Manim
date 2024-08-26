//
//  AttachedObject.swift
//  Manim
//
//  Created by Vaida on 8/27/24.
//


public struct AttachedObject {
    
    let base: MObject
    
}


public extension MObject {
    
    func attached() -> AttachedObject {
        AttachedObject(base: self)
    }
    
}
