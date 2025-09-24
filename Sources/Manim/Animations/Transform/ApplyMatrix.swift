//
//  ApplyMatrix.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/12.
//




extension MObject {
    
    /// Applies the transition matrix.
    public func apply(matrix: [[Double]], center: Point? = nil) -> WrappedAnimation {
        WrappedAnimation(base: self.pythonObject, caller: manim.ApplyMatrix, arguments: [("about_point", center), ("matrix", matrix)])
    }
    
}
