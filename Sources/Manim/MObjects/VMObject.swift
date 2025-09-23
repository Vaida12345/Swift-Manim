//
//  VMObject.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//


import SwiftUI


/// A vectorized ``MObject``.
public class VMObject: MObject {
    
    /// Set the offset
    ///
    /// - Parameters:
    ///   - x: The offset in x-axis.
    ///   - y: The offset in y-axis.
    ///   - z: The offset in z-axis.
    @discardableResult
    public func offset(x: (any Number)? = nil, y: (any Number)? = nil, z: (any Number)? = nil) -> AttachedAnimation {
        AttachedAnimation(name: "shift", target: self.identifier, args: [(nil, "\(x?.representation ?? "0") * RIGHT + \(y?.representation ?? "0") * UP + \(z?.representation ?? "0") * OUT")])
    }
    
}
