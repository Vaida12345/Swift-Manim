//
//  AttachedAnimation.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import Foundation


/// An animation that is attached to an object, typically means it is called using `.animate.modifier()`.
public class AttachedAnimation: Animation {
    
    let name: String
    
    let target: String
    
    let args: [(key: String?, value: String?)]
    
    init(name: String, target: String, args: [(key: String?, value: String?)]) {
        self.name = name
        self.target = target
        self.args = args
        
        super.init()
        
        // only called when not animate
        guard !shouldUseAnimation else { return }
        Generator.main.add("\(self.target).\(self.name)\(__formArgs(self.args))")
    }
    
    required init(identifier: String) {
        fatalError("init() has not been implemented")
    }
    
}
