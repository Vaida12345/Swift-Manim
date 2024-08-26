//
//  MObject.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//


import SwiftUI


/// Mathematical Object: base class for objects that can be displayed on screen.
public class MObject: PyObject {
    
    /// The bottom point.
    public var bottom: Method<Point> {
        Method<Point>(name: "get_bottom", args: [], parent: self)
    }
    
    /// The starting point.
    public var origin: Method<Point> {
        Method<Point>(name: "get_start", args: [], parent: self)
    }
    
    /// The center point.
    public var center: Method<Point> {
        Method<Point>(name: "get_center", args: [], parent: self)
    }
    
    /// Returns the point, where the stroke that surrounds the object ends.
    public var end: Method<Point> {
        Method<Point>(name: "get_end", args: [], parent: self)
    }
    
    /// Returns the point, where the stroke that surrounds the object starts.
    public var start: Method<Point> {
        Method<Point>(name: "get_start", args: [], parent: self)
    }
    
    /// A convenience interface for ``SetAction/x(_:)``
    public var x: ValueTracker {
        get {
            fatalError("\(#function) does not support a get method. This is a convenience interface for setting")
        }
        set {
            self.set.x(newValue)
        }
    }
    
    /// A convenience interface for ``SetAction/y(_:)``
    public var y: ValueTracker {
        get {
            fatalError("\(#function) does not support a get method. This is a convenience interface for setting")
        }
        set {
            self.set.y(newValue)
        }
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
        AttachedAnimation(name: "set_fill", target: self.identifier, args: [("color", color.pyDescription),
                                                                            ("opacity", opacity.description)])
    }
    
    /// Set the color and opacity.
    @discardableResult
    public func set(color: Color) -> AttachedAnimation {
        AttachedAnimation(name: "set_color", target: self.identifier, args: [("color", color.pyDescription)])
    }
    
    /// Moves to the given point.
    @discardableResult
    public func move(to point: PointLike, alignedEdges: Axis = Axis(), coordinateMask: Axis = .all) -> AttachedAnimation {
        AttachedAnimation(name: "move_to", target: self.identifier, args: [("point_or_mobject", point.pyDescription),
                                                                           ("aligned_edge", alignedEdges.pyDescription),
                                                                           ("coor_mask", coordinateMask.pyDescription)])
    }
    
    /// Moves to the center of given object.
    @discardableResult
    public func move(to target: MObject, alignedEdges: Axis = Axis(), coordinateMask: Axis = .all) -> AttachedAnimation {
        AttachedAnimation(name: "move_to", target: self.identifier, args: [("point_or_mobject", target.identifier),
                                                                           ("aligned_edge", alignedEdges.pyDescription),
                                                                           ("coor_mask", coordinateMask.pyDescription)])
    }
    
    /// Moves to the center of given object.
    @discardableResult
    public func move(to target: AttachedObject, alignedEdges: Axis = Axis(), coordinateMask: Axis = .all) -> AttachedAnimation {
        target.base.addUpdater(initialCall: false) { object in
            self.move(to: object, alignedEdges: alignedEdges, coordinateMask: coordinateMask)
        }
        
        return self.move(to: target.base, alignedEdges: alignedEdges, coordinateMask: coordinateMask)
    }
    
    /// Moves the object along the border of the `path` object,
    @discardableResult
    public func move(along path: MObject) -> Animation {
        ActionAnimation(name: "MoveAlongPath", args: [(nil, path.identifier)]).makeAnimation(object: self)
    }
    
    /// Set the stroke color and stroke opacity.
    ///
    /// - Parameters:
    ///   - color: stroke color.
    ///   - width: stroke color width.
    ///   - opacity: stroke opacity.
    @discardableResult
    public func stroke(_ color: Color, width: Double = 10, opacity: Double = 1) -> AttachedAnimation {
        AttachedAnimation(name: "set_stroke", target: self.identifier, args: [("color", color.pyDescription),
                                                                              ("opacity", opacity.description),
                                                                              ("width", width.description)])
    }
    
    /// Moves the current object next to `target`.
    @available(*, deprecated, renamed: "move(nextTo:position:padding:)")
    public func next(to target: MObject, position: Direction, padding: Double = 0) {
        self.attribute("next_to", to: [(nil, target.identifier),
                                       (nil, position.pyDescription),
                                       ("buff", padding.description)])
    }
    
    /// Moves the current object next to `target`.
    ///
    /// - Parameters:
    ///   - position: The position of `self` relative to `target`
    @discardableResult
    public func move(nextTo target: MObject, position: Direction, padding: Double = 0.25) -> AttachedAnimation {
        AttachedAnimation(name: "next_to", target: self.identifier, args: [(nil, target.identifier),
                                                                           (nil, position.pyDescription),
                                                                           ("buff", padding.description)])
    }
    
    /// Moves the current object next to `target`.
    ///
    /// - Parameters:
    ///   - position: The position of `self` relative to `target`
    @discardableResult
    public func move(nextTo target: Method<Point>, position: Direction, padding: Double = 0.25) -> AttachedAnimation {
        if !target.isDetached {
            self.addUpdater(initialCall: false) { object in
                self.attribute("next_to", to: [(nil, target.pyDescription),
                                                 (nil, position.pyDescription),
                                                 ("buff", padding.description)])
            }
        }
        
        return AttachedAnimation(name: "next_to", target: self.identifier, args: [(nil, target.pyDescription),
                                                                           (nil, position.pyDescription),
                                                                           ("buff", padding.description)])
    }
    
    /// Moves the current object next to `target`.
    ///
    /// - Parameters:
    ///   - position: The position of `self` relative to `target`
    @discardableResult
    public func move(nextTo target: AttachedObject, position: Direction, padding: Double = 0.25) -> AttachedAnimation {
        AttachedAnimation(
            name: "next_to",
            target: self.identifier,
            args: [(nil, target.base.identifier),
                   (nil, position.pyDescription),
                   ("buff", padding.description)]) {
                       self.addUpdater(initialCall: false) { object in
                           object.attribute("next_to", to: [(nil, target.base.identifier),
                                                            (nil, position.pyDescription),
                                                            ("buff", padding.description)])
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
                                                                          ("axis", axis.pyDescription)])
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
        Generator.main.add("def \(functionName)(\(object.identifier)):")
        indentCount += 1
        handler(object)
        indentCount -= 1
        Generator.main.add("")
        self.attribute("add_updater", to: [("update_function", functionName),
                                           ("index", index?.description),
                                           ("call_updater", initialCall.pyDescription)])
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
    public func become(_ target: MObject, copyChildren: Bool = true, matchHeight: Bool = false, matchWidth: Bool = false, matchDepth: Bool = false, matchCenter: Bool = false, stretch: Bool = false) -> AttachedAnimation {
        AttachedAnimation(name: "become", target: self.identifier, args: [(nil, target.identifier),
                                                                          ("copy_submobjects", copyChildren.pyDescription),
                                                                          ("match_height", matchHeight.pyDescription),
                                                                          ("match_width", matchWidth.pyDescription),
                                                                          ("match_depth", matchDepth.pyDescription),
                                                                          ("match_center", matchCenter.pyDescription),
                                                                          ("stretch", stretch.pyDescription),
                                                                         ])
    }
    
    /// Create and return an identical copy of the object including all children.
    public func copied() -> Self {
        Generator.main.assign(type: Self.self, by: self, calling: "copy", args: [])
    }
    
    /// Flips/Mirrors an object about its center.
    @discardableResult
    public func flip(axis: Axis) -> AttachedAnimation {
        AttachedAnimation(name: "flip", target: self.identifier, args: [(nil, axis.pyDescription)])
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
