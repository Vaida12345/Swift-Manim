//
//  Hide.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//



public enum HideAnimation: Equatable {
    
    /// No animation, just hide the object.
    case none
    
    /// Fade In.
    ///
    /// - Parameters:
    ///   - shift: Fade in with shift, with the direction being `shift`.
    ///   - scale: Fade in with scale. `scale` defines the initial scaling.
    case fadeOut(shift: Direction? = nil, scale: Double? = nil)
    
    /// The default way of un-creation, by un-drawing the borders.
    case uncreate
    
    /// The style to texts, remove text letter by letter.
    case removeTextByLetter
    
    /// Unwrite the text, by drawing the borders and then fill.
    case unwrite
    
    /// Animation that makes am object shrink to the object's center.
    case shrinkToCenter
    
    /// Fade Out.
    static let fadeOut: HideAnimation = .fadeOut()
    
    fileprivate var name: String {
        switch self {
        case .none:
            "none"
        case .fadeOut:
            "FadeOut"
        case .uncreate:
            "Uncreate"
        case .removeTextByLetter:
            "RemoveTextLetterByLetter"
        case .unwrite:
            "Unwrite"
        case .shrinkToCenter:
            "ShrinkToCenter"
        }
    }
    
    fileprivate var args: Closure.Arguments {
        switch self {
        case let .fadeOut(shift, scale):
            [("shift", shift?.representation), ("scale", scale?.description)]
        default:
            []
        }
    }
    
}


extension MObject {
    
    /// Hide the object.
    @discardableResult
    public func hide(animation: HideAnimation = .uncreate) -> Animation {
        if animation == .none {
            Generator.main.add("self.remove(\(self.identifier))")
        } else {
            if shouldUseAnimation {
                return Animation(base: animation.name, args: [(nil, self.identifier)] + animation.args)
            } else {
                Generator.main.add("self.play(\(animation.name)\(([(nil, self.identifier)] + animation.args).representation))")
            }
        }
        
        return EmptyAnimation()
    }
    
}
