//
//  Hide.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import PythonKit


@MainActor
public struct HideAnimation {
    
    let caller: PythonObject
    
    let arguments: Closure.Arguments
    
    init(caller: PythonObject, arguments: Closure.Arguments = []) {
        self.caller = caller
        self.arguments = arguments
    }
    
    /// Fade Out.
    ///
    /// - Parameters:
    ///   - shift: Fade out with shift, with the direction being `shift`.
    ///   - scale: Fade out with scale. `scale` defines the initial scaling.
    public static func fadeOut(shift: Direction? = nil, scale: Double? = nil) -> HideAnimation {
        HideAnimation(caller: manim.FadeOut, arguments: [("shift", shift), ("scale", scale)])
    }
    
    /// The default way of un-creation, by un-drawing the borders.
    public static let uncreate = HideAnimation(caller: manim.UnCreate)
    
    /// The style to texts, remove text letter by letter.
    public static let removeTextByLetter = HideAnimation(caller: manim.RemoveTextLetterByLetter)
    
    /// Unwrite the text, by drawing the borders and then fill.
    public static let unwrite = HideAnimation(caller: manim.Unwrite)
    
    /// Animation that makes am object shrink to the object's center.
    public static let shrinkToCenter = HideAnimation(caller: manim.ShrinkToCenter)
    
    /// Fade Out.
    public static let fadeOut: HideAnimation = .fadeOut()
    
}


extension MObject {
    
    /// Hide the object.
    @discardableResult
    public func hide(animation: HideAnimation = .unwrite) -> Animation {
        if !shouldUseAnimation {
            withAnimation {
                self.hide().duration(0)
            }
            
            return EmptyAnimation()
        } else {
            return WrappedAnimation(base: self.pythonObject, caller: animation.caller, arguments: animation.arguments)
        }
    }
    
}
