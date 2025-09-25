//
//  Transformable.swift
//  Manim
//
//  Created by Vaida on 2025-09-20.
//

import SwiftUI
import PythonKit


/// A protocol indicating that it can be moved.
@MainActor
public protocol Transformable {
    
    var _transformable: PythonObject { get }
    
}



extension Transformable {
    
    // MARK: - Move Suite
    
    /// Moves to the given point.
    @discardableResult
    public func move(to target: Point, alignedEdges: Axis = Axis(), coordinateMask: Axis = .all) -> AttachedAnimation {
        var closure = Closure(name: "move_to")
        closure.append("point_or_mobject", target.pythonObject)
        closure.append("aligned_edge", alignedEdges)
        closure.append("coor_mask", coordinateMask)
        return AttachedAnimation(base: self._transformable, closure: closure)
    }
    
    /// Moves to the given point.
    @discardableResult
    public func move(to target: MObject, alignedEdges: Axis = Axis(), coordinateMask: Axis = .all) -> AttachedAnimation {
        var closure = Closure(name: "move_to")
        closure.append("point_or_mobject", target.pythonObject)
        closure.append("aligned_edge", alignedEdges)
        closure.append("coor_mask", coordinateMask)
        return AttachedAnimation(base: self._transformable, closure: closure)
    }

    /// Moves the current object next to `target`.
    ///
    /// - Parameters:
    ///   - position: The position of `self` relative to `target`
    @discardableResult
    public func move(nextTo target: Point, placing: Direction, padding: Double = 0.25) -> AttachedAnimation {
        var closure = Closure(name: "next_to")
        closure.append("", target.pythonObject)
        closure.append("", placing)
        closure.append("buff", padding)
        
        return AttachedAnimation(base: self._transformable, closure: closure)
    }
    
    /// Moves the current object next to `target`.
    ///
    /// - Parameters:
    ///   - position: The position of `self` relative to `target`
    @discardableResult
    public func move(nextTo target: MObject, placing: Direction, padding: Double = 0.25) -> AttachedAnimation {
        var closure = Closure(name: "next_to")
        closure.append("", target.pythonObject)
        closure.append("", placing)
        closure.append("buff", padding)
        
        return AttachedAnimation(base: self._transformable, closure: closure)
    }
    
    
    /// Move `self` below `target`.
    @discardableResult
    public func move(below target: Point, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .bottom, padding: padding)
    }
    
    /// Move `self` below `target`.
    @discardableResult
    public func move(below target: MObject, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .bottom, padding: padding)
    }
    
    /// Move `self` above `target`.
    @discardableResult
    public func move(above target: Point, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .top, padding: padding)
    }
    
    /// Move `self` above `target`.
    @discardableResult
    public func move(above target: MObject, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .top, padding: padding)
    }
    
    /// Move `self` to the left of `target`.
    @discardableResult
    public func move(leftOf target: Point, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .left, padding: padding)
    }
    
    /// Move `self` to the left of `target`.
    @discardableResult
    public func move(leftOf target: MObject, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .left, padding: padding)
    }
    
    /// Move `self` to the right of `target`.
    @discardableResult
    public func move(rightOf target: Point, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .right, padding: padding)
    }
    
    /// Move `self` to the right of `target`.
    @discardableResult
    public func move(rightOf target: MObject, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .right, padding: padding)
    }
    
    
    // MARK: - Implicit Move
    
    /// Shifts by the given vector.
    @discardableResult
    public func shift(by point: Point) -> AttachedAnimation {
        AttachedAnimation(base: self._transformable, closure: Closure("shift", [("", point)]))
    }
    
    /// Moves the object along the border of the `path` object,
    @discardableResult
    public func moveAlong(pathOf object: MObject) -> WrappedAnimation {
        WrappedAnimation(base: self._transformable, caller: manim.MoveAlongPath, arguments: [("", object.pythonObject)])
    }
    
    /// Rotates the object about a certain point.
    ///
    /// - Parameters:
    ///   - angle: The rotation angle.
    ///   - axis: The rotation axis.
    @discardableResult
    public func rotate(angle: Angle, axis: Axis = .z) -> AttachedAnimation {
        AttachedAnimation(base: self._transformable, closure: Closure("rotate", [("angle", angle.radians), ("axis", axis)]))
    }
    
    /// Scale the object by a factor.
    ///
    /// - Parameters:
    ///   - factor: The scale factor.
    ///   - stroke: Whether to scale the stroke width as well.
    @discardableResult
    public func scale(_ factor: Double, stroke: Bool = false) -> AttachedAnimation {
        AttachedAnimation(base: self._transformable, closure: Closure("scale", [("", factor), ("scale_stroke", stroke)]))
    }
    
    /// Flips/Mirrors an object about its center.
    @discardableResult
    public func flip(axis: Axis) -> AttachedAnimation {
        AttachedAnimation(base: self._transformable, closure: Closure("flip", [("", axis)]))
    }
    
}
