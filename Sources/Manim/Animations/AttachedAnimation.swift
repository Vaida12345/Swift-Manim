//
//  AttachedAnimation.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import PythonKit
import SwiftUI


/// An animation that is attached to an object.
public final class AttachedAnimation: Animation {
    
    let base: PythonObject
    
    let closure: Closure
    
    var path: Path = .straight
    
    
    override func callAsFunction() -> PythonObject {
        var body: PythonObject {
            var args = Closure.Arguments()
            args.append("run_time", self.duration)
            args.append("lag_ratio", self.lagRatio)
            
            switch path {
            case .straight:
                break
            case .arc(let angle):
                args.append("path_arc", angle.radians)
            }
            
            return self.base.animate.dynamicallyCall(withKeywordArguments: args)[dynamicMember: self.closure.name].dynamicallyCall(withKeywordArguments: self.closure.arguments)
        }
        
        if self.delay != 0 {
            return manim.Succession(manim.Wait(self.delay), body)
        } else {
            return body
        }
    }
    
    
    /// Sets the path that the transition should follow.
    ///
    /// ![Preview](trace)
    ///
    /// ```swift
    /// let dot = Dot(at: [2, 0])
    /// let trace = dot.trace(\.center, dissipatingTime: 0.5)
    /// scene.add(dot, trace)
    ///
    /// withAnimation(in: .serial) {
    ///     dot.shift(by: [-2, 0])
    ///         .path(.arc(.degrees(45)))
    /// }
    /// ```
    public func path(_ path: Path) -> AttachedAnimation {
        self.path = path
        return self
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
    
    
    public enum Path {
        /// A straight line
        case straight
        /// A curved arc.
        case arc(Angle)
    }
    
}
