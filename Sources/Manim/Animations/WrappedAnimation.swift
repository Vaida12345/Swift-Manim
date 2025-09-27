//
//  WrappedAnimation.swift
//  Manim
//
//  Created by Vaida on 2025-09-24.
//

import PythonKit


/// Implementation details: animations that are achieved by wrapping in a caller
public class WrappedAnimation: Animation {
    
    let base: PythonObject
    
    let caller: PythonObject
    
    let arguments: Closure.Arguments
    
    
    init(base: PythonObject, caller: PythonObject, arguments: Closure.Arguments = []) {
        self.base = base
        self.caller = caller
        self.arguments = arguments
        
        super.init()
        
        if !shouldUseAnimation {
            self.preAction()
            var arguments = self.arguments
            arguments.insert("", self.base, at: 0)
            self.caller.dynamicallyCall(withKeywordArguments: arguments)
            self.completionHandler()
        }
    }
    
    
    override func callAsFunction() -> PythonObject {
        var body: PythonObject {
            var arguments = self.arguments
            arguments.insert("", self.base, at: 0)
            return self.caller.dynamicallyCall(withKeywordArguments: arguments)
        }
        
        var group: PythonObject {
            var arguments = Closure.Arguments()
            arguments.append("", body)
            arguments.append("run_time", self.duration)
            arguments.append("lag_ratio", self.lagRatio)
            
            return manim.AnimationGroup.dynamicallyCall(withKeywordArguments: arguments)
        }
        
        if self.delay != 0 {
            return manim.Succession(manim.Wait(self.delay), group)
        } else {
            return group
        }
    }
    
}
