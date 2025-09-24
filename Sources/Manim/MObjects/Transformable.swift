//
//  Transformable.swift
//  Manim
//
//  Created by Vaida on 2025-09-20.
//

import MacroCollection
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
    @varyArgumentType(Point.self, variation: MObject.self)
    @discardableResult
    public func move(to target: Point, alignedEdges: Axis = Axis(), coordinateMask: Axis = .all) -> AttachedAnimation {
        var closure = Closure(name: "move_to")
        closure.append("point_or_mobject", target)
        closure.append("aligned_edge", alignedEdges)
        closure.append("coor_mask", coordinateMask)
        return AttachedAnimation(base: self._transformable, closure: closure)
    }

    /// Moves the current object next to `target`.
    ///
    /// - Parameters:
    ///   - position: The position of `self` relative to `target`
    @varyArgumentType(Point.self, variation: MObject.self)
    @discardableResult
    public func move(nextTo target: Point, placing: Direction, padding: Double = 0.25) -> AttachedAnimation {
        var closure = Closure(name: "next_to")
        closure.append("", target)
        closure.append("", placing)
        closure.append("buff", padding)
        
        return AttachedAnimation(base: self._transformable, closure: closure)
    }
    
    
    /// Move `self` below `target`.
    @varyArgumentType(Point.self, variation: MObject.self)
    @discardableResult
    public func move(below target: Point, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .down, padding: padding)
    }
    
    /// Move `self` above `target`.
    @varyArgumentType(Point.self, variation: MObject.self)
    @discardableResult
    public func move(above target: Point, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .up, padding: padding)
    }
    
    /// Move `self` to the left of `target`.
    @varyArgumentType(Point.self, variation: MObject.self)
    @discardableResult
    public func move(leftOf target: Point, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .left, padding: padding)
    }
    
    /// Move `self` to the right of `target`.
    @varyArgumentType(Point.self, variation: MObject.self)
    @discardableResult
    public func move(rightOf target: Point, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .right, padding: padding)
    }
    
    /// Moves the ``MObject/start`` and ``MObject/end``.
    @discardableResult
    public func moveTo(start: Point, end: Point) -> AttachedAnimation {
        AttachedAnimation(base: self._transformable, closure: Closure("put_start_and_end_on", [("", start), ("", end)]))
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
        WrappedAnimation(base: self._transformable, caller: manim.MoveAlongPath, arguments: [("", object)])
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
    @discardableResult
    public func scale(_ factor: Double) -> AttachedAnimation {
        AttachedAnimation(base: self._transformable, closure: Closure("scale", [("", factor)]))
    }
    
    /// Flips/Mirrors an object about its center.
    @discardableResult
    public func flip(axis: Axis) -> AttachedAnimation {
        AttachedAnimation(base: self._transformable, closure: Closure("flip", [("", axis)]))
    }
    
}
