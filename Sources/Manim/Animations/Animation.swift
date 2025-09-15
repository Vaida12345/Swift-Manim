//
//  Animation.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import OSLog


/// An animation.
public class Animation: PyObject {
    
    var delay: Double = 0
    
    var duration: Double = 2
    
    var lagRatio: Double = 0
    
    
    required init(identifier: String) { super.init(identifier: identifier) }
    
    override init(base: String? = nil, args: Args) {
        super.init(base: base, args: args)
    }
    
    init() {
        super.init(identifier: __formVariableName(base: "\(Self.self)"))
    }
    
    
    public enum Method {
        case serial, parallel
    }
    
}

extension Animation {
    
    /// Specifies the delay
    public func delay(_ seconds: Double) -> Self {
        self.delay = seconds
        return self
    }
    
    /// Specifies the duration of the animation.
    public func duration(_ seconds: Double) -> Self {
        if duration == 0 {
            let logger = Logger(subsystem: "Manim", category: "Animation.duration(_:)")
            logger.warning("Attempting to give a duration of zero. This could prevent the video from rendering.")
        }
        
        self.duration = seconds
        return self
    }
    
    /// The delay after which the animation is applied to children.
    ///
    /// This lag is relative to the duration of the animation.
    ///
    /// This does not influence the total runtime of the animation. Instead the runtime of individual animations is adjusted so that the complete animation has the defined run time.
    ///
    /// [View example on MainmCE](https://docs.manim.community/en/stable/reference/manim.animation.animation.Animation.html#lagratios)
    public func lagRatio(_ ratio: Double) -> Self {
        self.lagRatio = ratio
        return self
    }
    
}


internal class EmptyAnimation: Animation {
    
}


/// Animates the closure when possible.
///
/// - Parameters:
///   - animation: the animation function.
///   - method: The manner in which the closures are executed.
///   - body: The body of animation.
///
/// You can use this method to set the animation of transition. Simply wrapping code with this method is sufficient to introduce an animation.
///
/// ```swift
/// withAnimation {
///     originText.align(.down, to: dot)
/// }
/// ```
public func withAnimation(_ animation: RateFunction = .spring, in method: Animation.Method = .serial, @_AnimationBuilder body: () -> _AnimationGroup) {
    shouldUseAnimation = true
    let animations = body()
        .get()
        .filter { !($0 is EmptyAnimation) }
    
    guard !animations.isEmpty else { return }
    
    let body = animations
        .map { animation in
            var body: String {
                if let attached = animation as? AttachedAnimation {
                    return "\(attached.target).animate.\(attached.name)\(__formArgs(attached.args))"
                } else {
                    return animation.identifier
                }
            }
            
            var group: String {
                "AnimationGroup(\(body), run_time=\(animation.duration), lag_ratio=\(animation.lagRatio))"
            }
            
            if animation.delay != 0 {
                return "Succession(Wait(\(animation.delay)), \(group))"
            } else {
                return group
            }
        }
    
    switch method {
    case .serial:
        Generator.main.add("self.play(Succession(\(body.joined(separator: ", "))), rate_func=rate_functions.\(animation.rawValue))")
        
    case .parallel:
        Generator.main.add("self.play(AnimationGroup(\(body.joined(separator: ", "))), rate_func=rate_functions.\(animation.rawValue))")
    }
    
    shouldUseAnimation = false
    
    for animation in animations {
        if let animation = animation as? AttachedAnimation {
            animation.onFinished()
        }
    }
}


/// Internal use, for `@resultBuilder`.
@resultBuilder
public enum _AnimationBuilder {
    
    public static func buildBlock(_ components: Animation...) -> _AnimationGroup {
        _AnimationGroup(animations: components)
    }
    
    public static func buildArray(_ components: [_AnimationGroup]) -> _AnimationGroup {
        _AnimationGroup(animations: components)
    }
}

/// Internal use, for `@resultBuilder`.
public final class _AnimationGroup: Animation {
    
    let animations: [Animation]
    
    func get() -> [Animation] {
        self.animations.flatMap { animation in
            if let animation = animation as? _AnimationGroup {
                animation.get()
            } else {
                [animation]
            }
        }
    }
    
    init(animations: [Animation]) {
        self.animations = animations
        
        super.init()
    }
    
    required init(identifier: String) { fatalError() }
    
}
