//
//  HStack.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//




/// A horizontal stack
public final class HStack: VGroup {
    
    public init(_ children: MObject...) {
        super.init(children)
        super.arrange(direction: .right)
    }
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
}
