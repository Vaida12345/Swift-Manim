//
//  AttachedAnimation.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import PythonKit


/// An animation that is attached to an object, typically means it is called using `.animate.modifier()`.
///
/// > Declaration:
/// > ```swift
/// > AttachedAnimation(base: self, closure: Closure(<#name#>, <#args#>))
/// > ```
public final class AttachedAnimation: Animation {
    
    let base: PythonObject
    
    let closure: Closure
    
    let completionHandler: () -> Void
    
    
    override func callAsFunction() -> PythonObject {
        var body: PythonObject {
            self.base.animate(run_time: self.duration, lag_ratio: self.lagRatio)[dynamicMember: self.closure.name].dynamicallyCall(withKeywordArguments: self.closure.arguments)
        }
        
        if self.delay != 0 {
            return manim.Succession(manim.Wait(self.delay), body)
        } else {
            return body
        }
    }
    
    
    init(base: PythonObject, closure: Closure, completionHandler: @escaping () -> Void = {}) {
        self.base = base
        self.closure = closure
        self.completionHandler = completionHandler
        
        super.init()
        
        if !shouldUseAnimation {
            self.base[dynamicMember: self.closure.name].dynamicallyCall(withKeywordArguments: self.closure.arguments)
        }
    }
    
    convenience init(base: MObject, closure: Closure, completionHandler: @escaping () -> Void = {}) {
        self.init(base: base.pythonObject, closure: closure, completionHandler: completionHandler)
    }
    
}
