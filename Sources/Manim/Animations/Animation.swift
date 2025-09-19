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
    
    var duration: Double = 1
    
    var lagRatio: Double = 0
    
    
    init() {
        super.init(identifier: __formVariableName(base: "\(Self.self)"))
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) { super.init(typeIdentifier, arguments: arguments) }
    
    
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
    ///
    /// By default, the duration is `1`.
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
    /// [read more](<doc:Animations>)
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
@MainActor
public func withAnimation(_ animation: RateFunction = .linear, in method: Animation.Method = .serial, @_AnimationBuilder body: () -> _AnimationGroup) {
    shouldUseAnimation = true
    let animations = body()
        .get()
        .filter { !($0 is EmptyAnimation) }
    
    guard !animations.isEmpty else { return }
    
    let body = animations
        .map { animation in
            if let attached = animation as? AttachedAnimation {
                var body: String {
                    var arguments = Closure.Arguments()
                    arguments.append("run_time", animation.duration.description, when: .notEqual("1.0"))
                    arguments.append("lag_ratio", animation.lagRatio.description, when: .notEqual("0.0"))
                    
                    return "\(attached.target).animate\(arguments.representation).\(attached.closure.representation)"
                }
                
                if animation.delay != 0 {
                    return "Succession(Wait(\(animation.delay)), \(body))"
                } else {
                    return body
                }
            } else {
                var body: String {
                    if let attached = animation as? AttachedAnimation {
                        return "\(attached.target).animate.\(attached.closure.representation)"
                    } else {
                        return animation.identifier
                    }
                }
                
                var group: String {
                    var arguments = Closure.Arguments()
                    arguments.append(nil, body)
                    arguments.append("run_time", animation.duration.description, when: .notEqual("1.0"))
                    arguments.append("lag_ratio", animation.lagRatio.description, when: .notEqual("0.0"))
                    
                    return "AnimationGroup\(arguments)"
                }
                
                if animation.delay != 0 {
                    return "Succession(Wait(\(animation.delay)), \(group))"
                } else {
                    return group
                }
            }
        }
    
    let rateFunction: String
    if animation == .linear {
        rateFunction = ""
    } else {
        rateFunction = ", rate_func=rate_functions.\(animation.rawValue)"
    }
    
    if body.count == 1 {
        Generator.main.add("self.play(\(body.first!)\(rateFunction))")
    } else {
        switch method {
        case .serial:
            for animation in body {
                Generator.main.add("self.play(\(animation)\(rateFunction))")
            }
            
        case .parallel:
            Generator.main.add("self.play(AnimationGroup(\(body.joined(separator: ", ")))\(rateFunction))")
        }
    }
    
    shouldUseAnimation = false
    
    for animation in animations {
        if let animation = animation as? AttachedAnimation {
            animation.onFinished()
        }
    }
}


/// Internal use, for `@resultBuilder`.
@MainActor
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
@MainActor
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
    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) { fatalError() }
    
}
