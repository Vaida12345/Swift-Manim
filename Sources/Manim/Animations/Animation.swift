//
//  Animation.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import OSLog
import PythonKit


/// An animation.
@MainActor
public class Animation {
    
    var delay: Double = 0
    
    var duration: Double = 1
    
    var lagRatio: Double = 0
    
    var completionHandler: () -> Void = { }
    
    var preAction: () -> Void = { }
    
    func callAsFunction() -> PythonObject {
        fatalError()
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
    
    /// Specifies a completion handler.
    ///
    /// - Warning: When not executed in ``withAnimation(_:in:body:)``, `onCompletion` and `preAction` may be executed in any order.
    public func onCompletion(_ body: @escaping () -> Void) -> Self {
        if shouldUseAnimation {
            let oldHandler = self.completionHandler
            self.completionHandler = { oldHandler(); body() }
            return self
        } else {
            body()
            return self
        }
    }
    
    /// Specifies an action that is executed right before the animation.
    ///
    /// - Warning: When not executed in ``withAnimation(_:in:body:)``, `onCompletion` and `preAction` may be executed in any order.
    public func preAction(_ body: @escaping () -> Void) -> Self {
        if shouldUseAnimation {
            let oldPreAction = self.preAction
            self.preAction = { oldPreAction(); body() }
            return self
        } else {
            body()
            return self
        }
    }
    
}


internal final class EmptyAnimation: Animation {
    
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
///
/// - Warning: Starting from `PythonKit` branch, animations happen in ``Animation/Method/parallel`` by default.
@MainActor
public func withAnimation(_ animation: RateFunction = .easeInOut, in method: Animation.Method = .parallel, @_AnimationBuilder body: () -> _AnimationGroup) {
    shouldUseAnimation = true
    let animations = body()
        .get()
        .filter { !($0 is EmptyAnimation) }
     shouldUseAnimation = false
    
    switch method {
    case .serial:
        for ani in animations {
            ani.preAction()
            scene.play(ani(), rate_func: animation)
            ani.completionHandler()
        }
        
    case .parallel:
        for animation in animations {
            animation.preAction()
        }
        scene.play(manim.AnimationGroup(animations.map({ $0() })), rate_func: animation)
        for animation in animations {
            animation.completionHandler()
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
    
}
