//
//  Action.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/12.
//

import PythonKit
import SwiftUI


extension MObject {
    
    /// Flash a box around the object, then remove the box.
    ///
    /// ```swift
    /// let text = Text("Circumscribe")
    /// scene.add(text)
    ///
    /// withAnimation {
    ///     text.circumscribe()
    /// }
    /// ```
    ///
    /// ![Preview](Circumscribe)
    public func circumscribe(shape: CircumscribeShape = .rectangle, style: CircumscribeStyle = .lineDrawInOut(delta: 0.5), color: Color = .yellow) -> WrappedAnimation {
        WrappedAnimation(base: self.pythonObject, caller: manim.Circumscribe, arguments: [("shape", shape), ("color", color)] + style.args)
    }
    
    @MainActor
    public enum CircumscribeShape: @MainActor PythonConvertible {
        case circle
        case rectangle
        
        public var pythonObject: PythonObject {
            switch self {
            case .circle:
                manim.Circle
            case .rectangle:
                manim.Rectangle
            }
        }
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
                [("fade_out", true)]
            case .lineDrawOut:
                [("fade_in", true)]
            case .lineDrawInOut(let delta):
                [("time_width", delta)]
            }
        }
    }
    
}

extension MObject {
    
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
    public func flash(lineLength: Double = 0.2, lineCount: Int = 12, radius: Double = 0.1, strokeWidth: Double = 3, color: Color = .yellow) -> WrappedAnimation {
        WrappedAnimation(base: self.pythonObject, caller: manim.Flash, arguments: [
            ("line_length", lineLength),
            ("num_lines", lineCount),
            ("flash_radius", radius),
            ("line_stroke_width", strokeWidth),
            ("color", color),
        ])
    }
    
    /// Shrink a spotlight to a position.
    ///
    /// - Parameters:
    ///   - opacity: The opacity of the spotlight.
    ///   - color: The color of the spotlight.
    public func focuse(opacity: Double = 0.2, color: Color = .gray) -> WrappedAnimation {
        WrappedAnimation(base: self.pythonObject, caller: manim.FocusOn, arguments: [
            ("opacity", opacity),
            ("color", color),
        ])
    }
    
    /// Indicate an object by temporarily resizing and recoloring it.
    ///
    /// - Parameters:
    ///   - scale: The factor by which the object will be temporally scaled
    ///   - color: The color the object temporally takes.
    public func indicate(scale: Double = 1.2, color: Color = .yellow) -> WrappedAnimation {
        WrappedAnimation(base: self.pythonObject, caller: manim.Indicate, arguments: [
            ("scale_factor", scale),
            ("color", color),
        ])
    }
    
    /// Wiggle an object.
    public func shake() -> WrappedAnimation {
        WrappedAnimation(base: self.pythonObject, caller: manim.Wiggle)
    }
    
    /// Show only a sliver of the object each frame.
    ///
    /// The effect is similar to ``circumscribe(shape:style:)``.
    ///
    /// - Note: The action would remove the object prior and after. During the animation, it will only show the object (and path) partially.
    ///
    /// - Parameters:
    ///   - duration: The length of the sliver relative to the length of the stroke.
    public func showPassingFlash(duration: Double = 0.1) -> WrappedAnimation {
        WrappedAnimation(base: self.pythonObject, caller: manim.ShowPassingFlash, arguments: [
            ("time_width", duration)
        ])
    }
    
}
