//
//  ApplyMatrix.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/12.
//




extension MObject {
    
    /// Applies the transition matrix.
    public func apply(matrix: [[Double]], center: Point? = nil) -> Animation {
        ActionAnimation(name: "ApplyMatrix", args: [
            ("about_point", center?.representation),
            ("matrix", matrix.description),
        ]).makeAnimation(object: self)
    }
    
}
