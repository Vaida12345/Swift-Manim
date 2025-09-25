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
    
    
    init(base: PythonObject, closure: Closure) {
        self.base = base
        self.closure = closure
        
        super.init()
        
        if !shouldUseAnimation {
            self.preAction()
            self.base[dynamicMember: self.closure.name].dynamicallyCall(withKeywordArguments: self.closure.arguments)
            self.completionHandler()
        }
    }
    
    convenience init(base: MObject, closure: Closure) {
        self.init(base: base.pythonObject, closure: closure)
    }
    
}
