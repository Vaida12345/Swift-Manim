//
//  MObject.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import MacroCollection
import SwiftUI


/// Mathematical Object: base class for objects that can be displayed on screen.
public class MObject: PyObject {
    
    /// Internal state, tracks if the object is attached by calling 
    internal var isAttached: Bool = false
    
    /// Sets `self` as attached, any changes to `self` will be reflected on the object it is attached to.
    public func attached() -> Self {
        self.isAttached = true
        return self
    }
    
    /// Set the fill color and fill opacity.
    ///
    /// - Parameters:
    ///   - color: Fill color.
    ///   - opacity: Fill opacity.
    @discardableResult
    public func fill(_ color: Color, opacity: Double = 1) -> AttachedAnimation {
        AttachedAnimation(name: "set_fill", target: self.identifier, args: [("color", color.representation),
                                                                            ("opacity", opacity.description)])
    }
    
    /// Set the color and opacity.
    @discardableResult
    public func set(color: Color) -> AttachedAnimation {
        AttachedAnimation(name: "set_color", target: self.identifier, args: [("color", color.representation)])
    }
    
    /// Add `child` as sub object.
    public func add(_ child: MObject) {
        self.call("add", arguments: [(nil, child.identifier)])
    }
    
    /// Rotates the object about a certain point.
    ///
    /// - Parameters:
    ///   - angle: The rotation angle.
    ///   - axis: The rotation axis.
    @discardableResult
    public func rotate(angle: Angle, axis: Axis = .z) -> AttachedAnimation {
        AttachedAnimation(name: "rotate", target: self.identifier, args: [("angle", angle.radians.description),
                                                                          ("axis", axis.representation)])
    }
    
    /// Set the stroke color and stroke opacity.
    ///
    /// - Parameters:
    ///   - color: stroke color.
    ///   - width: stroke color width.
    ///   - opacity: stroke opacity.
    @discardableResult
    public func stroke(_ color: Color, width: Double = 10, opacity: Double = 1) -> AttachedAnimation {
        AttachedAnimation(name: "set_stroke", target: self.identifier, args: [("color", color.representation),
                                                                              ("opacity", opacity.description),
                                                                              ("width", width.description)])
    }
    
    /// Scale the object by a factor.
    @discardableResult
    public func scale(factor: Double) -> AttachedAnimation {
        AttachedAnimation(name: "scale", target: self.identifier, args: [(nil, factor.description)])
    }
    
    /// Add an update function to this object.
    ///
    /// Update functions, or updaters in short, are functions that are applied to the Mobject in every frame.
    ///
    /// - Parameters:
    ///   - index: The index at which the new updater should be added.
    ///   - initialCall: Whether or not to call the updater initially.
    ///   - handler: The update handler.
    public func addUpdater(index: Int? = nil, initialCall: Bool = false, handler: (MObject) -> Void) {
        let object = MObject(identifier: __formVariableName(base: "\(MObject.self)"))
        let functionName = __formVariableName(base: "updater\(Self.self)")
        Generator.main.newLine()
        Generator.main.add("def \(functionName)(\(object.identifier)):")
        Generator.main.indentCount += 1
        handler(object)
        Generator.main.indentCount -= 1
        Generator.main.newLine()
        
        var arguments = Closure.Arguments()
        arguments.append("update_function", functionName)
        arguments.append("index", index?.description)
        arguments.append("call_updater", initialCall, when: .notEqual(false))
        
        self.call("add_updater", arguments: arguments)
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
    @discardableResult
    public func become(_ target: MObject, matchHeight: Bool = false, matchWidth: Bool = false, matchDepth: Bool = false, matchCenter: Bool = false, stretch: Bool = false) -> AttachedAnimation {
        var arguments = Closure.Arguments()
        arguments.append(nil, target.identifier)
        arguments.append("match_height", matchHeight, when: .notEqual(false))
        arguments.append("match_width",  matchWidth,  when: .notEqual(false))
        arguments.append("match_depth",  matchDepth,  when: .notEqual(false))
        arguments.append("match_center", matchCenter, when: .notEqual(false))
        arguments.append("stretch",      stretch,     when: .notEqual(false))
        
        return AttachedAnimation(name: "become", target: self.identifier, args: arguments)
    }
    
    /// Create and return an identical copy of the object including all children.
    public func copied() -> Self {
        Generator.main.assign(type: Self.self, by: self, calling: "copy", args: [])
    }
    
    /// Flips/Mirrors an object about its center.
    @discardableResult
    public func flip(axis: Axis) -> AttachedAnimation {
        AttachedAnimation(name: "flip", target: self.identifier, args: [(nil, axis.representation)])
    }
    
    
//    /// Creates an instance with the initializer.
//    ///
//    /// - Parameters:
//    ///   - base: The class name in Python. Pass `nil` if you want to use the Swift class name.
//    ///   - args: The arguments passed to the Python class initializer.
//    ///
//    /// This initializer creates an identifier of the newly created Python instance for you.
//    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) {
//        let base = typeIdentifier ?? "\(Self.self)"
//        
//        if shouldOverrideInit {
//            super.init(identifier: "", typeIdentifier: typeIdentifier, arguments: arguments)
//        } else {
//            let identifier = __formVariableName(base: base)
//            super.init(identifier: identifier, typeIdentifier: typeIdentifier, arguments: arguments)
//        }
//    }
//    
//    required init(identifier: String) { super.init(identifier: identifier) }
    
}
