//
//  HStack.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//




/// A horizontal stack
public final class HStack: Group {
    
    public init(_ children: MObject..., spacing: Double = 0.25) {
        super.init(children)
        super.arrange(direction: .right, spacing: spacing)
    }
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
}
