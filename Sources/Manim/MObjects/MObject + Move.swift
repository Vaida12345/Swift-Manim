//
//  MObject + Move.swift
//  Manim
//
//  Created by Vaida on 2025-09-20.
//

import MacroCollection


extension MObject {
    
    // MARK: - Move Suite
    
    /// Moves to the given point.
    @discardableResult
    public func move(to point: some PointProtocol, alignedEdges: Axis = Axis(), coordinateMask: Axis = .all) -> AttachedAnimation {
        AttachedAnimation(name: "move_to", target: self.identifier, args: [("point_or_mobject", point.representation),
                                                                           ("aligned_edge", alignedEdges.representation),
                                                                           ("coor_mask", coordinateMask.representation)])
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
                    object.call("move_to", arguments: args)
                }
            }
        }
    }
    
    /// Moves the current object next to `target`.
    @available(*, deprecated, renamed: "move(nextTo:placing:padding:)")
    public func next(to target: MObject, position: Direction, padding: Double = 0) {
        self.call("next_to", arguments: [(nil, target.identifier),
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
    public func move(nextTo target: Point, placing: Direction, padding: Double = 0.25) -> AttachedAnimation {
        var arguments = Closure.Arguments()
        arguments.append(nil, target)
        arguments.append(nil, placing)
        arguments.append("buff", padding.description, when: .notEqual("0.25"))
        
        return AttachedAnimation(name: "next_to", target: self.identifier, args: arguments)
    }
    
    
    /// Move `self` below `target`.
    @varyArgumentType(Point.self, variation: ReadableProperty<Point>.self)
    @varyArgumentType(Point.self, variation: MObject.self)
    @discardableResult
    public func move(below target: Point, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .down, padding: padding)
    }
    
    /// Move `self` above `target`.
    @varyArgumentType(Point.self, variation: ReadableProperty<Point>.self)
    @varyArgumentType(Point.self, variation: MObject.self)
    @discardableResult
    public func move(above target: Point, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .up, padding: padding)
    }
    
    /// Move `self` to the left of `target`.
    @varyArgumentType(Point.self, variation: ReadableProperty<Point>.self)
    @varyArgumentType(Point.self, variation: MObject.self)
    @discardableResult
    public func move(leftOf target: Point, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .left, padding: padding)
    }
    
    /// Move `self` to the right of `target`.
    @varyArgumentType(Point.self, variation: ReadableProperty<Point>.self)
    @varyArgumentType(Point.self, variation: MObject.self)
    @discardableResult
    public func move(rightOf target: Point, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .right, padding: padding)
    }
    
    
    // MARK: - Implicit Move
    
    /// Moves to the given point.
    @discardableResult
    public func shift(by point: some PointProtocol) -> AttachedAnimation {
        AttachedAnimation(name: "shift", target: self.identifier, args: [(nil, point.representation)])
    }
    
    /// Moves the object along the border of the `path` object,
    @discardableResult
    public func moveAlong(pathOf object: MObject) -> Animation {
        ActionAnimation(name: "MoveAlongPath", args: [(nil, object.identifier)]).makeAnimation(object: self)
    }
    
}
