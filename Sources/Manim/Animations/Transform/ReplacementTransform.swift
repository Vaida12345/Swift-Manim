//
//  ReplacementTransform.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//




/// Replaces and morphs a ``MObject`` into a target ``MObject``.
private class ReplacementTransform: Transform {
    
}


extension MObject {
    
    /// Replaces and morphs a ``MObject`` into a target ``MObject``.
    public func replacementTransform(to target: MObject) -> Animation { ReplacementTransform(from: self, to: target, option: nil) }
    
}
