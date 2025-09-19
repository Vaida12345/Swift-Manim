//
//  VStack.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//


/// A vertical stack
public final class VStack: Group {
    
    public convenience init(spacing: Double = 0.25, _ children: [MObject]) {
        self.init(children)
        super.arrange(direction: .down, spacing: spacing)
    }
    
    public convenience init(spacing: Double = 0.25, _ children: MObject...) {
        self.init(spacing: spacing, children)
    }
    
}
