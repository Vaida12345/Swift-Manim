//
//  ReplacementTransform.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//



extension MObject {
    
    /// Replaces and morphs a ``MObject`` into a target ``MObject``.
    public func replacementTransform(to target: MObject) -> WrappedAnimation {
        WrappedAnimation(base: self.pythonObject, caller: manim.ReplacementTransform, arguments: [("", target)]) 
    }
    
}
