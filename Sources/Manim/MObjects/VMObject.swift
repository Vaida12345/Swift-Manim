//
//  VMObject.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import Foundation
import SwiftUI


/// A vectorized ``MObject``.
public class VMObject: MObject {
    
    /// Set the offset
    ///
    /// - Parameters:
    ///   - x: The offset in x.
    ///   - y: The offset in y.
    @discardableResult
    public func offset(x: Double? = nil, y: Double? = nil, z: Double? = nil) -> AttachedAnimation {
        AttachedAnimation(name: "shift", target: self.identifier, args: [(nil, "\(x ?? 0) * RIGHT + \(y ?? 0) * UP + \(z ?? 0) * OUT")])
    }
    
    
    override init(base: String? = nil, args: Args) {
        super.init(base: base, args: args)
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    
}
