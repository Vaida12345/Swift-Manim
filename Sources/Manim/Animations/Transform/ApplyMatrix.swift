//
//  ApplyMatrix.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/12.
//

import Foundation


extension MObject {
    
    /// Applies the transition matrix.
    public func apply(matrix: [[Double]], center: Point? = nil) -> Animation {
        ActionAnimation(name: "ApplyMatrix", args: [
            ("about_point", center?.pyDescription),
            ("matrix", matrix.description),
        ]).makeAnimation(object: self)
    }
    
}
