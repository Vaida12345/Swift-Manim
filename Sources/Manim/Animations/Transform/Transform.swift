//
//  Transform.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import PythonKit


/// A Transform transforms a Mobject into a target Mobject.
///
/// Instead of creating instances of this class directly, you use ``MObject/transform(to:style:)``.
@MainActor
public final class Transform: WrappedAnimation {
    
    var path: Transform.Path = .straight
    
    
    /// Sets the path that the transition should follow.
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Transform.mov)
    /// 
    /// ```swift
    /// let dot = Dot(at: [-2, 0])
    /// let dest = Dot(at: [2, 0])
    /// scene.add(dest, dot)
    ///
    /// withAnimation {
    ///     dot.transform(to: dest)
    ///         .path(.clockwise)
    /// }
    /// ```
    public func path(_ path: Transform.Path) -> Transform {
        self.path = path
        return self
    }
    
    
    override func callAsFunction() -> PythonObject {
        var body: PythonObject {
            var arguments = self.arguments
            arguments.insert("", self.base, at: 0)
            arguments.append("path_func", self.path)
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


extension MObject {
    
    /// Creates a transformation.
    ///
    /// - Parameters:
    ///   - target: The destination.
    ///   - transform: The transform used.
    ///
    /// - SeeAlso: ``Transform`` for cases and example videos.
    ///
    /// ```swift
    /// let dot = Dot(at: [-2, 0])
    /// let dest = Dot(at: [2, 0])
    /// scene.add(dest, dot)
    ///
    /// withAnimation {
    ///     dot.transform(to: dest)
    ///         .path(.clockwise)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Transform.mov)
    public func transform(to target: MObject, style transform: Transform.Style = .plain) -> Transform {
        Transform(base: self.pythonObject, caller: transform.pythonObject, arguments: [("", target.pythonObject)])
    }
    
}
