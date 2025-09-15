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
    
    /// The internal store
    internal var store: [String : Any] = [:]
    
    /// Internal state, tracks if the object is attached by calling 
    internal var isAttached: Bool = false
    
    /// Sets `self` as attached, any changes to `self` will be reflected on the object it is attached to.
    public func attached() -> Self {
        self.isAttached = true
        return self
    }
    
    /// The bottom point.
    public var bottom: ReadableProperty<Point> {
        ReadableProperty(origin: self, read: Closure("get_bottom", []))
    }
    
    /// The starting point.
    public var origin: ReadableProperty<Point> {
        ReadableProperty(origin: self, read: Closure("get_start", []))
    }
    
    /// The center point.
    public var center: ReadableProperty<Point> {
        ReadableProperty(origin: self, read: Closure("get_center", []))
    }
    
    /// Returns the point, where the stroke that surrounds the object ends.
    public var end: ReadableProperty<Point> {
        ReadableProperty(origin: self, read: Closure("get_end", []))
    }
    
    /// Returns the point, where the stroke that surrounds the object starts.
    public var start: ReadableProperty<Point> {
        ReadableProperty(origin: self, read: Closure("get_start", []))
    }
    
    public var x: ReadWriteProperty<Double> {
        ReadWriteProperty(origin: self, read: Closure("get_x", []), write: Closure("set_x", []))
    }
    
    public var y: ReadWriteProperty<Double> {
        ReadWriteProperty(origin: self, read: Closure("get_y", []), write: Closure("set_y", []))
    }
    
    
    /// Controls the states.
    public var state: State {
        State(base: self)
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
    
    /// Moves to the given point.
    @discardableResult
    public func move(to point: some PointProtocol, alignedEdges: Axis = Axis(), coordinateMask: Axis = .all) -> AttachedAnimation {
        AttachedAnimation(name: "move_to", target: self.identifier, args: [("point_or_mobject", point.representation),
                                                                           ("aligned_edge", alignedEdges.representation),
                                                                           ("coor_mask", coordinateMask.representation)])
    }
    
    /// Moves to the given point.
    @discardableResult
    public func shift(by point: some PointProtocol) -> AttachedAnimation {
        AttachedAnimation(name: "shift", target: self.identifier, args: [(nil, point.representation)])
    }
    
    /// Moves to the center of given object.
    @discardableResult
    public func move(to target: MObject, alignedEdges: Axis = Axis(), coordinateMask: Axis = .all) -> AttachedAnimation {
        let args: Closure.Arguments = [
            ("point_or_mobject", target.identifier),
            ("aligned_edge", alignedEdges.representation),
            ("coor_mask", coordinateMask.representation)
        ]
        
        return AttachedAnimation(name: "move_to", target: self.identifier, args: args) {
            if target.isAttached {
                self.addUpdater(initialCall: false) { object in
                    object.attribute("move_to", to: args)
                }
            }
        }
    }
    
    /// Moves the object along the border of the `path` object,
    @discardableResult
    public func moveAlong(pathOf object: MObject) -> Animation {
        ActionAnimation(name: "MoveAlongPath", args: [(nil, object.identifier)]).makeAnimation(object: self)
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
    
    /// Moves the current object next to `target`.
    @available(*, deprecated, renamed: "move(nextTo:position:padding:)")
    public func next(to target: MObject, position: Direction, padding: Double = 0) {
        self.attribute("next_to", to: [(nil, target.identifier),
                                       (nil, position.representation),
                                       ("buff", padding.description)])
    }
    
    /// Moves the current object next to `target`.
    ///
    /// - Parameters:
    ///   - position: The position of `self` relative to `target`
    @varyArgumentType(Point.self, variation: ReadableProperty<Point>.self)
    @varyArgumentType(Point.self, variation: MObject.self)
    @discardableResult
    public func move(nextTo target: Point, position: Direction, padding: Double = 0.25) -> AttachedAnimation {
//        if !target.isDetached {
//            self.addUpdater(initialCall: false) { object in
//                self.attribute("next_to", to: [(nil, target.representation),
//                                                 (nil, position.representation),
//                                                 ("buff", padding.description)])
//            }
//        }
        
        return AttachedAnimation(name: "next_to", target: self.identifier, args: [(nil, target.representation),
                                                                           (nil, position.representation),
                                                                           ("buff", padding.description)])
    }
    
    /// Moves the current object next to `target`.
    ///
    /// Use this method to align objects.
    /// ```swift
    /// let dot = Dot(at: .center)
    /// let text = Text("(0, 0)")
    ///
    /// text.align(.down, to: dot)
    /// ```
    ///
    /// ![result](align)
    ///
    /// - Tip: You can use ``withAnimation(duration:delay:animation:body:)`` to animate the movement of `self` from its original position.
    ///
    /// - Parameters:
    ///   - position: The position of `self` relative to `target`
    @discardableResult
    public func align(_ position: Direction, to target: MObject, padding: Double = 0.25) -> AttachedAnimation {
        let args: Closure.Arguments = [
            (nil, target.identifier),
            (nil, position.representation),
            ("buff", padding.description)
        ]
        return AttachedAnimation(
            name: "next_to",
            target: self.identifier,
            args: args) {
                if target.isAttached {
                    self.addUpdater(initialCall: false) { object in
                        object.attribute("next_to", to: args)
                    }
                }
            }
    }
    
    /// Add `child` as sub object.
    public func add(_ child: MObject) {
        self.attribute("add", to: [(nil, child.identifier)])
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
        Generator.main.add("")
        Generator.main.add("def \(functionName)(\(object.identifier)):")
        indentCount += 1
        handler(object)
        indentCount -= 1
        Generator.main.add("")
        self.attribute("add_updater", to: [("update_function", functionName),
                                           ("index", index?.description),
                                           ("call_updater", initialCall.representation)])
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
        AttachedAnimation(name: "become", target: self.identifier, args: [(nil, target.identifier),
                                                                          ("match_height", matchHeight.representation),
                                                                          ("match_width", matchWidth.representation),
                                                                          ("match_depth", matchDepth.representation),
                                                                          ("match_center", matchCenter.representation),
                                                                          ("stretch", stretch.representation),
                                                                         ])
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
    
    
    public final class State {
        
        let base: MObject
        
        init(base: MObject) {
            self.base = base
        }
        
        /// Save the states of the object.
        public func save() {
            Generator.main.add("\(base.identifier).save_state()")
        }
        
        /// Transforms an object to its last saved state, ``save()``.
        @discardableResult
        public func restore() -> Animation {
            ActionAnimation(name: "Restore", args: []).makeAnimation(object: base)
        }
        
    }
    
}
