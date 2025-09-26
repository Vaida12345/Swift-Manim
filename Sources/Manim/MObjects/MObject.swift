//
//  MObject.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import SwiftUI
import PythonKit


/// Mathematical Object: The base class for objects that can be displayed on screen.
///
/// Most concrete classes inherit from `MObject`. You do not create instances directly from this abstract class; instead, you create instances of concrete classes that inherit the properties and methods of `MObject`.
///
/// ```swift
/// let dot = Dot(at: [1, 2])
/// let text = Text("(1, 2)")
/// let numberLine = NumberPlane()
///
/// text.move(below: dot)
/// scene.add(numberLine, dot, text)
/// print(dot.x) // 1
/// ```
///
/// ![Preview](coord)
@MainActor
public class MObject: @MainActor CustomStringConvertible, @MainActor Transformable {
    
    internal var pythonObject: PythonKit.PythonObject
    
    public var description: String {
        "\(type(of: self as Any))(\(self.pythonObject))"
    }
    
    public var _transformable: PythonObject {
        self.pythonObject
    }
    
    /// Creates an instance with the initializer.
    internal required init(_ pythonObject: PythonObject) {
        self.pythonObject = pythonObject
    }
    
    
    /// Sets the color.
    ///
    /// Sets both the ``VMObject/fillColor`` and ``VMObject/strokeColor``. This method also calls ``VMObject/set(opacity:)`` internally.
    ///
    /// ```swift
    /// let rect = Square(length: 2)
    ///
    /// withAnimation {
    ///     rect.set(color: .red)
    /// }
    /// ```
    ///
    /// ![Preview](set_color)
    @discardableResult
    public func set(color: Color) -> Animation {
        _AnimationGroup(animations: [
            AttachedAnimation(base: self, closure: Closure("set_color", [("color", color)])),
            AttachedAnimation(base: self, closure: Closure("set_opacity", [("opacity", color.alpha)])),
        ])
    }
    
    /// Add `child` as sub object.
    public func add(_ child: MObject) {
        self.pythonObject.add(child.pythonObject)
    }
    
    /// Remove `child` as sub object.
    ///
    /// - Note: This has no effect if `child` is not a children of `self`.
    public func remove(_ child: MObject) {
        self.pythonObject.remove(child.pythonObject)
    }
    
    /// Edit points, colors and sub objects to be identical to another ``MObject``.
    ///
    /// - Parameters:
    ///   - target: The target object
    ///   - matchHeight: If `true`, then the transformed object will match the height of the original
    ///   - matchWidth: If `true`, then the transformed object will match the width of the original
    ///   - matchDepth: If `true`, then the transformed object will match the depth of the original
    ///   - matchCenter: If `true`, then the transformed object will match the center of the original
    ///   - stretch: If `true`, then the transformed object will stretch to fit the proportions of the original
    ///
    /// ```swift
    /// let rect = Rectangle(width: 4, height: 2)
    /// let dot = Dot()
    ///
    /// withAnimation {
    ///     rect.become(dot)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/become.mov)
    @discardableResult
    public func become(_ target: MObject, matchHeight: Bool = false, matchWidth: Bool = false, matchDepth: Bool = false, matchCenter: Bool = false, stretch: Bool = false) -> AttachedAnimation {
        var closure = Closure("become")
        closure.append("", target.pythonObject)
        closure.append("match_height", matchHeight)
        closure.append("match_width",  matchWidth)
        closure.append("match_depth",  matchDepth)
        closure.append("match_center", matchCenter)
        closure.append("stretch",      stretch)
        
        return AttachedAnimation(base: self, closure: closure)
    }
    
    /// Create and return an identical deep copy of the object including all children.
    public func copied() -> Self {
        Self(self.pythonObject.copy())
    }
    
    /// Scales the instance to fit the `height` while keeping width/depth proportional.
    ///
    /// ```swift
    /// let rect = Rectangle(width: 4, height: 2)
    ///
    /// withAnimation {
    ///     rect.scaleToFit(height: 1)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/scaleToFit.mov)
    @discardableResult
    public func scaleToFit(height: Double) -> AttachedAnimation {
        AttachedAnimation(base: self, closure: Closure("scale_to_fit_height", [("", height)]))
    }
    
    /// Scales the instance to fit the `width` while keeping width/depth proportional.
    ///
    /// ```swift
    /// let rect = Rectangle(width: 4, height: 2)
    ///
    /// withAnimation {
    ///     rect.scaleToFit(width: 2)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/scaleToFit.mov)
    @discardableResult
    public func scaleToFit(width: Double) -> AttachedAnimation {
        AttachedAnimation(base: self, closure: Closure("scale_to_fit_width", [("", width)]))
    }
    
}
