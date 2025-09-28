//
//  Action.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/12.
//

import PythonKit


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
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/circumscribe.mov)
    ///
    /// ## Topics
    /// - ``CircumscribeShape``
    /// - ``CircumscribeStyle``
    public func circumscribe(shape: CircumscribeShape = .rectangle, style: CircumscribeStyle = .lineDrawInOut(delta: 0.5), color: Color = .yellow) -> WrappedAnimation {
        WrappedAnimation(base: self._pythonObject, caller: manim.Circumscribe, arguments: [("shape", shape), ("color", color)] + style.args)
    }
    
}

/// An enumeration of shapes used to circumscribe an MObject when applying the `circumscribe` animation.
///
/// You can use ``MObject/circumscribe(shape:style:color:)`` to circumscribe an object.
@MainActor
public enum CircumscribeShape: @MainActor PythonConvertible {
    ///  Draws a circular outline centered on the object.
    case circle
    /// Draws a rectangular outline matching the object's bounding box.
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


/// An enumeration of styles used to circumscribe an MObject when applying the `circumscribe` animation.
///
/// You can use ``MObject/circumscribe(shape:style:color:)`` to circumscribe an object.
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
    ///
    /// ```swift
    /// let dot = Dot()
    /// dot.show()
    ///
    /// withAnimation {
    ///     dot.flash()
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/flash.mov)
    public func flash(lineLength: Double = 0.2, lineCount: Int = 12, radius: Double = 0.1, strokeWidth: Double = 3, color: Color = .yellow) -> WrappedAnimation {
        WrappedAnimation(base: self._pythonObject, caller: manim.Flash, arguments: [
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
    ///   - color: The color of the spotlight.
    ///
    /// ```swift
    /// let dot = Dot()
    /// dot.show()
    ///
    /// withAnimation {
    ///     dot.focus()
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/focus.mov)
    public func focus(color: Color = .gray.opacity(0.2)) -> WrappedAnimation {
        WrappedAnimation(base: self._pythonObject, caller: manim.FocusOn, arguments: [
            ("opacity", color.alpha),
            ("color", color),
        ])
    }
    
    /// Indicate an object by temporarily resizing and recoloring it.
    ///
    /// - Parameters:
    ///   - scale: The factor by which the object will be temporally scaled
    ///   - color: The color the object temporally takes.
    ///
    /// ```swift
    /// let text = Text("Here!")
    /// text.show()
    ///
    /// withAnimation {
    ///     text.indicate()
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/indicate.mov)
    public func indicate(scale: Double = 1.2, color: Color = .yellow) -> WrappedAnimation {
        WrappedAnimation(base: self._pythonObject, caller: manim.Indicate, arguments: [
            ("scale_factor", scale),
            ("color", color),
        ])
    }
    
    /// Wiggle an object.
    ///
    /// ```swift
    /// let text = Text("Here!")
    /// text.show()
    ///
    /// withAnimation {
    ///     text.shake()
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/shake.mov)
    public func shake() -> WrappedAnimation {
        WrappedAnimation(base: self._pythonObject, caller: manim.Wiggle)
    }
    
    /// Show only a sliver of the object each frame.
    ///
    /// The effect is similar to ``circumscribe(shape:style:color:)``.
    ///
    /// - Note: The action would remove the object prior and after. During the animation, it will only show the object (and path) partially.
    ///
    /// - Parameters:
    ///   - duration: The length of the sliver relative to the length of the stroke.
    ///
    /// ```swift
    /// let rect = Rectangle(width: 4, height: 2, stroke: .blue)
    /// rect.show()
    ///
    /// withAnimation {
    ///     rect.showPassingFlash()
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/showPassingFlash.mov)
    public func showPassingFlash(duration: Double = 0.1) -> WrappedAnimation {
        WrappedAnimation(base: self._pythonObject, caller: manim.ShowPassingFlash, arguments: [
            ("time_width", duration)
        ])
    }
    
}
