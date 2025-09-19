//
//  Action.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/12.
//


import SwiftUI


/// An animation that represents an action by a ``MObject``.
///
/// You can call an `ActionAnimation` using ``MObject/action(_:)``.
@MainActor
public struct ActionAnimation: @MainActor Equatable {
    
    fileprivate let closure: Closure
    
    fileprivate let overrideMObject: ((String) -> String)?
    
    
    internal init(name: String, args: Closure.Arguments, overrideMObject: ((String) -> String)? = nil) {
        self.closure = Closure(name, args)
        self.overrideMObject = overrideMObject
    }
    
    
    /// Flash a box around the object, then remove the box.
    public static func circumscribe(shape: CircumscribeShape = .rectangle, style: CircumscribeStyle = .lineDrawInOut(delta: 0.5)) -> ActionAnimation {
        ActionAnimation(name: "Circumscribe", args: [("shape", shape.rawValue)] + style.args)
    }
    
    /// Send out lines in all directions.
    ///
    /// - Note: This function will not take account into the shape of object.
    ///
    /// - Parameters:
    ///   - lineLength: The length of the flash lines.
    ///   - lineCount: The number of flash lines.
    ///   - radius: The distance from point at which the flash lines start.
    ///   - strokeWidth: The stroke width of the flash lines.
    ///   - color: The color of the flash lines.
    public static func flash(lineLength: Double? = nil, lineCount: Int? = nil, radius: Double? = nil, strokeWidth: Double? = nil, color: Color? = nil) -> ActionAnimation {
        ActionAnimation(name: "Flash", args: [
            ("line_length", lineLength?.description),
            ("num_lines", lineCount?.description),
            ("flash_radius", radius?.description),
            ("line_stroke_width", strokeWidth?.description),
            ("color", color?.representation),
        ])
    }
    
    /// Shrink a spotlight to a position.
    ///
    /// - Parameters:
    ///   - opacity: The opacity of the spotlight.
    ///   - color: The color of the spotlight.
    public static func focused(opacity: Double? = nil, color: Color? = nil) -> ActionAnimation {
        ActionAnimation(name: "FocusOn", args: [
            ("opacity", opacity?.description),
            ("color", color?.representation),
        ])
    }
    
    /// Indicate an object by temporarily resizing and recoloring it.
    ///
    /// - Parameters:
    ///   - scale: The factor by which the object will be temporally scaled
    ///   - color: The color the object temporally takes.
    public static func indicated(scale: Double? = nil, color: Color? = nil) -> ActionAnimation {
        ActionAnimation(name: "Indicate", args: [
            ("scale_factor", scale?.description),
            ("color", color?.representation),
        ])
    }
    
    /// Wiggle an object.
    public static func shake() -> ActionAnimation {
        ActionAnimation(name: "Wiggle", args: [])
    }
    
    /// Animation that rotates an object.
    ///
    /// - Parameters:
    ///   - angle: The rotation angle.
    ///   - axis: The rotation axis.
    ///   - center: The rotation center.
    public static func rotate(angle: Angle? = nil, axis: Axis? = nil, center: Point? = nil) -> ActionAnimation {
        ActionAnimation(name: "Rotate", args: [
            ("angle", angle?.radians.description),
            ("axis", axis?.representation),
            ("about_point", center?.representation),
        ])
    }
    
    /// Animation that rotates an object.
    ///
    /// - Parameters:
    ///   - angle: The rotation angle.
    ///   - axis: The rotation axis.
    ///   - center: The rotation center.
    public static func rotate(angle: Angle? = nil, axis: Axis? = nil, center: ReadableProperty<Point>) -> ActionAnimation {
        ActionAnimation(name: "Rotate", args: [
            ("angle", angle?.radians.description),
            ("axis", axis?.representation),
            ("about_point", center.representation),
        ])
    }
    
    /// Show only a sliver of the object each frame.
    ///
    /// The effect is similar to ``circumscribe(shape:style:)``.
    ///
    /// - Note: The action would remove the object prior and after.
    ///
    /// - Parameters:
    ///   - duration: The length of the sliver relative to the length of the stroke.
    public static func showPassingFlash(duration: Double? = nil) -> ActionAnimation {
        ActionAnimation(name: "ShowPassingFlash", args: [
            ("time_width", duration?.description)
        ])
    }
    
    /// Broadcast an object starting from an `initailWidth`, up to the actual size of the starting.
    ///
    /// - Parameters:
    ///   - center: The center of the broadcast, by default ORIGIN.
    ///   - count: The number of objects that emerge from the focal point, by default 5.
    ///   - opacity: The starting / final stroke opacity of the objects emitted from the broadcast.
    ///   - removed: Whether the objects should be removed from the scene after the animation, by default True.
    public static func broadcast(center: Point? = nil, count: Int? = nil, opacity: (start: Double, end: Double)? = nil, removed: Bool? = nil) -> ActionAnimation {
        ActionAnimation(name: "Broadcast", args: [
            ("focal_point", center?.representation),
            ("n_mobs", count?.description),
            ("initial_opacity", opacity?.start.description),
            ("final_opacity", opacity?.end.description),
            ("remover", removed?.representation),
        ])
    }
    
    /// An animation moving objects cyclically.
    ///
    /// In particular, this means: the first object takes the place of the second object, the second one takes the place of the third object, and so on. The last object takes the place of the first one.
    ///
    /// - Note: The action would only work on ``Group``.
    public static func cyclicReplace(duration: Double? = nil) -> ActionAnimation {
        ActionAnimation(name: "CyclicReplace", args: [], overrideMObject: { "*\($0)" })
    }
    
    
    internal func makeAnimation(object: MObject) -> Animation {
        if shouldUseAnimation {
            return Animation(self.closure.name, arguments: (overrideMObject != nil ? [(nil, overrideMObject!(object.identifier))] : [(nil, object.identifier)]) + self.closure.arguments)
        } else {
            Generator.main.add("self.play(\(self.closure.name)\(((overrideMObject != nil ? [(nil, overrideMObject!(object.identifier))] : [(nil, object.identifier)]) + self.closure.arguments).representation)")
        }
        
        return EmptyAnimation()
    }
    
    
    @MainActor
    public enum CircumscribeShape: String {
        case circle = "Circle"
        case rectangle = "Rectangle"
    }
    
    @MainActor
    public enum CircumscribeStyle {
        /// Draw the line to create, and fade out.
        case lineDrawIn
        
        /// Fade in, then un draw the lines.
        case lineDrawOut
        
        /// Draw the line to create, then undraw.
        /// - Parameters:
        ///   - delta: The time difference between the fadeIn and fadeOut.
        case lineDrawInOut(delta: Double)
        
        fileprivate var args: Closure.Arguments {
            switch self {
            case .lineDrawIn:
                [("fade_out", true.representation)]
            case .lineDrawOut:
                [("fade_in", true.representation)]
            case .lineDrawInOut(let delta):
                [("time_width", delta.description)]
            }
        }
    }
    
    
    public static func == (lhs: ActionAnimation, rhs: ActionAnimation) -> Bool {
        lhs.closure == rhs.closure
    }
    
}


extension MObject {
    
    /// Calls an action animation.
    @discardableResult
    public func action(_ animation: ActionAnimation) -> Animation {
        animation.makeAnimation(object: self)
    }
    
}
