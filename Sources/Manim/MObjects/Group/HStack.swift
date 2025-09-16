//
//  HStack.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//


/// A horizontal stack
public final class HStack: Group {
    
    public init(spacing: Double = 0.25, _ children: [MObject]) {
        super.init(children)
        super.arrange(direction: .right, spacing: spacing)
    }
    
    public convenience init(spacing: Double = 0.25, _ children: MObject...) {
        self.init(spacing: spacing, children)
    }
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
}
