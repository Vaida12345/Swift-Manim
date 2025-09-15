//
//  VStack.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//



/// A vertical stack
public final class VStack: Group {
    
    public init(_ children: MObject..., spacing: Double = 0.25) {
        super.init(children)
        super.arrange(direction: .down, spacing: spacing)
    }
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
}
