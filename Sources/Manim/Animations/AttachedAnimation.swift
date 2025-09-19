//
//  AttachedAnimation.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import OSLog


/// An animation that is attached to an object, typically means it is called using `.animate.modifier()`.
public class AttachedAnimation: Animation {
    
    let closure: Closure
    
    let target: String
    
    let onFinished: () -> Void
    
    
    init(name: String, target: String, args: Closure.Arguments, onFinished: @escaping () -> Void = {}) {
        self.closure = Closure(name, args)
        self.target = target
        self.onFinished = onFinished
        
        super.init()
        
        // only called when not animate
        guard !shouldUseAnimation else { return }
        Generator.main.add("\(self.target).\(closure.representation)")
    }
    
    required init(identifier: String) {
        fatalError("init() has not been implemented")
    }
    
    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) {
        fatalError("init(_:arguments:) has not been implemented")
    }
    
}
