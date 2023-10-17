//
//  Animation.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//




/// An animation.
public class Animation: PyObject {
    
    required init(identifier: String) { super.init(identifier: identifier) }
    
    override init(base: String? = nil, args: Args) {
        super.init(base: base, args: args)
    }
    
    init() {
        super.init(identifier: __formVariableName(base: "\(Self.self)"))
    }
    
}

internal class EmptyAnimation: Animation {
    
}


/// Animates the closure when possible.
///
/// The animations are executed in serial.
///
/// - Parameters:
///   - duration: The duration of **an** animation. It is not the total duration.
///   - delay: The delay of animation
///   - animation: The style of animation
///   - body: The body of animation
public func withAnimation(duration: Double? = nil, delay: Double? = nil, animation: RateFunction = .easeInOut, @AnimationBuilder body: () -> AnimationGroup) {
    shouldUseAnimation = true
    let animations = body()
    let body = animations
        .get()
        .filter { !($0 is EmptyAnimation) }
        .map { animation in
            if let attached = animation as? AttachedAnimation {
                "\(attached.target).animate.\(attached.name)\(__formArgs(attached.args))"
            } else {
                animation.identifier
            }
        }
    
    for _body in body {
        Generator.main.add("self.play(\(_body)\(duration != nil ? ", run_time=\(duration!+(delay ?? 0))" : "")\(delay != nil ? ", lag_ratio=\(delay!/((duration ?? 0) + delay!))" : ""), rate_func=rate_functions.\(animation.rawValue))")
    }
    shouldUseAnimation = false
}


/// animates all the given animations at the same time
///
/// - Parameters:
///   - duration: The duration of animation
///   - delay: The delay of **each** animation.
///   - animation: The style of animation
///   - body: The body of animation
public func withAnimationGroup(duration: Double? = nil, delay: Double? = nil, animation: RateFunction = .easeInOut, @AnimationBuilder _ body: () -> AnimationGroup) {
    shouldUseAnimation = true
    let animations = body()
    let body = animations
        .get()
        .filter { !($0 is EmptyAnimation) }
        .map { animation in
            if let attached = animation as? AttachedAnimation {
                "\(attached.target).animate.\(attached.name)\(__formArgs(attached.args))"
            } else {
                animation.identifier
            }
        }
        .joined(separator: ", ")
    Generator.main.add("self.play(LaggedStart(\(body)\(duration != nil ? ", run_time=\(duration!+(delay ?? 0))" : "")\(delay != nil ? ", lag_ratio=\(delay!/((duration ?? 0) + delay!))" : ""), rate_func=rate_functions.\(animation.rawValue)))")
    shouldUseAnimation = false
}


@resultBuilder
public enum AnimationBuilder {
    
    public static func buildBlock(_ components: Animation...) -> AnimationGroup {
        AnimationGroup(animations: components)
    }
    
    public static func buildArray(_ components: [AnimationGroup]) -> AnimationGroup {
        AnimationGroup(animations: components)
    }
}

public final class AnimationGroup: Animation {
    
    let animations: [Animation]
    
    func get() -> [Animation] {
        self.animations.flatMap { animation in
            if let animation = animation as? AnimationGroup {
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
