//
//  VStack.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//

import Foundation

/// A vertical stack
public final class VStack: VGroup {
    
    public init(_ children: MObject...) {
        super.init(children)
        super.arrange(direction: .down)
    }
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
}
