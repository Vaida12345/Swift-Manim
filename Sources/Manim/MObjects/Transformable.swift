//
//  Transformable.swift
//  Manim
//
//  Created by Vaida on 2025-09-20.
//

import PythonKit


/// A protocol indicating that it can be moved.
@MainActor
public protocol Transformable: AnyObject {
    
    var _pythonObject: PythonObject { get }
    
}



extension Transformable {
    
    // MARK: - Move Suite
    
    /// Moves to the given point.
    ///
    /// ```swift
    /// let dot = Dot()
    /// let dot2 = Dot(at: [2, 0])
    ///
    /// withAnimation {
    ///     dot.move(to: dot2.center)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/move_to.mov)
    @discardableResult
    public func move(to target: Point, alignedEdges: Axis = Axis(), coordinateMask: Axis = .all) -> AttachedAnimation {
        var closure = Closure(name: "move_to")
        closure.append("point_or_mobject", target.pythonObject)
        closure.append("aligned_edge", alignedEdges)
        closure.append("coor_mask", coordinateMask)
        return AttachedAnimation(base: self._pythonObject, closure: closure)
    }
    
    /// Moves to the given point.
    ///
    /// ```swift
    /// let dot = Dot()
    /// let dot2 = Dot(at: [2, 0])
    ///
    /// withAnimation {
    ///     dot.move(to: dot2)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/move_to.mov)
    @discardableResult
    public func move(to target: MObject, alignedEdges: Axis = Axis(), coordinateMask: Axis = .all) -> AttachedAnimation {
        var closure = Closure(name: "move_to")
        closure.append("point_or_mobject", target._pythonObject)
        closure.append("aligned_edge", alignedEdges)
        closure.append("coor_mask", coordinateMask)
        return AttachedAnimation(base: self._pythonObject, closure: closure)
    }

    /// Moves the current object next to `target`.
    ///
    /// - Parameters:
    ///   - target: The reference point
    ///   - placing: The position of `self` relative to `target`
    ///   - padding: The padding from `self` to `target`
    @discardableResult
    fileprivate func move(nextTo target: Point, placing: Direction, padding: Double = 0.25) -> AttachedAnimation {
        var closure = Closure(name: "next_to")
        closure.append("", target.pythonObject)
        closure.append("", placing)
        closure.append("buff", padding)
        
        return AttachedAnimation(base: self._pythonObject, closure: closure)
    }
    
    /// Moves the current object next to `target`.
    ///
    /// - Parameters:
    ///   - target: The reference point
    ///   - placing: The position of `self` relative to `target`
    ///   - padding: The padding from `self` to `target`
    @discardableResult
    fileprivate func move(nextTo target: MObject, placing: Direction, padding: Double = 0.25) -> AttachedAnimation {
        var closure = Closure(name: "next_to")
        closure.append("", target._pythonObject)
        closure.append("", placing)
        closure.append("buff", padding)
        
        return AttachedAnimation(base: self._pythonObject, closure: closure)
    }
    
    /// Move `self` below `target`.
    ///
    /// ```swift
    /// let dot = Dot()
    /// let rect = Rectangle(width: 4, height: 2)
    ///
    /// withAnimation {
    ///     dot.move(leftOf: rect)
    ///     dot.move(above: rect)
    ///     dot.move(rightOf: rect)
    ///     dot.move(below: rect)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/move_left_right.mov)
    @discardableResult
    public func move(below target: MObject, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .bottom, padding: padding)
    }
    
    /// Move `self` above `target`.
    ///
    /// ```swift
    /// let dot = Dot()
    /// let rect = Rectangle(width: 4, height: 2)
    ///
    /// withAnimation {
    ///     dot.move(leftOf: rect)
    ///     dot.move(above: rect)
    ///     dot.move(rightOf: rect)
    ///     dot.move(below: rect)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/move_left_right.mov)
    @discardableResult
    public func move(above target: MObject, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .top, padding: padding)
    }
    
    /// Move `self` to the left of `target`.
    ///
    /// ```swift
    /// let dot = Dot()
    /// let rect = Rectangle(width: 4, height: 2)
    ///
    /// withAnimation {
    ///     dot.move(leftOf: rect)
    ///     dot.move(above: rect)
    ///     dot.move(rightOf: rect)
    ///     dot.move(below: rect)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/move_left_right.mov)
    @discardableResult
    public func move(leftOf target: MObject, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .left, padding: padding)
    }
    
    /// Move `self` to the right of `target`.
    ///
    /// ```swift
    /// let dot = Dot()
    /// let rect = Rectangle(width: 4, height: 2)
    ///
    /// withAnimation {
    ///     dot.move(leftOf: rect)
    ///     dot.move(above: rect)
    ///     dot.move(rightOf: rect)
    ///     dot.move(below: rect)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/move_left_right.mov)
    @discardableResult
    public func move(rightOf target: MObject, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .right, padding: padding)
    }
    
    
    // MARK: - Implicit Move
    
    /// Shifts by the given vector.
    ///
    /// ```swift
    /// let dot = Dot()
    ///
    /// withAnimation {
    ///     dot.shift(by: [0, 2])
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/shift.mov)
    @discardableResult
    public func shift(by point: Point) -> AttachedAnimation {
        AttachedAnimation(base: self._pythonObject, closure: Closure("shift", [("", point)]))
    }
    
    /// Moves the object along the border of the `path` object.
    ///
    /// ```swift
    /// let dot = Dot()
    /// let rect = Rectangle(width: 4, height: 2)
    ///
    /// withAnimation {
    ///     dot.moveAlong(pathOf: rect)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/moveAlong_pathOf.mov)
    @discardableResult
    public func moveAlong(pathOf object: MObject) -> WrappedAnimation {
        WrappedAnimation(base: self._pythonObject, caller: manim.MoveAlongPath, arguments: [("", object._pythonObject)])
    }
    
    /// Rotates the object about a certain point.
    ///
    /// - Parameters:
    ///   - angle: The rotation angle.
    ///   - axis: The rotation axis.
    ///   - point: The rotation center.
    ///
    /// ```swift
    /// let rect = Rectangle(width: 4, height: 2)
    ///
    /// withAnimation {
    ///     rect.rotate(angle: .degrees(45), axis: .y)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/rotate.mov)
    @discardableResult
    public func rotate(angle: Angle, about point: Point? = nil, axis: Axis = .z) -> AttachedAnimation {
        AttachedAnimation(base: self._pythonObject, closure: Closure("rotate", [("angle", angle.radians), ("axis", axis), ("about_point", point)]))
    }
    
    /// Scale the object by a factor.
    ///
    /// - Parameters:
    ///   - factor: The scale factor.
    ///   - stroke: Whether to scale the stroke width as well.
    ///
    /// ```swift
    /// let dot = Dot()
    ///
    /// withAnimation {
    ///     dot.scale(3)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/scale.mov)
    @discardableResult
    public func scale(_ factor: Double, stroke: Bool = false) -> AttachedAnimation {
        AttachedAnimation(base: self._pythonObject, closure: Closure("scale", [("", factor), ("scale_stroke", stroke)]))
    }
    
    /// Flips/Mirrors an object about its center.
    ///
    /// ```swift
    /// let rect = Rectangle(width: 4, height: 2)
    ///
    /// withAnimation {
    ///     rect.flip(axis: .x)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/flip.mov)
    @discardableResult
    public func flip(axis: Axis) -> AttachedAnimation {
        AttachedAnimation(base: self._pythonObject, closure: Closure("flip", [("", axis)]))
    }
    
}


extension MObject {
    
    /// Moves to the given point.
    ///
    /// ```swift
    /// let dot = Dot()
    /// let dot2 = Dot(at: [2, 0])
    ///
    /// withAnimation {
    ///     dot.move(to: dot2.center)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/move_to.mov)
    @discardableResult
    public func move(to target: Projection<Point>, alignedEdges: Axis = Axis(), coordinateMask: Axis = .all) -> AttachedAnimation {
        self.addUpdater(self.move(to: target.wrappedValue, alignedEdges: alignedEdges, coordinateMask: coordinateMask))
    }
    
}


extension Transformable {
    
    /// Move `self` below `target`.
    ///
    /// ```swift
    /// let dot = Dot()
    /// let rect = Rectangle(width: 4, height: 2)
    ///
    /// withAnimation {
    ///     dot.move(leftOf: rect)
    ///     dot.move(above: rect)
    ///     dot.move(rightOf: rect)
    ///     dot.move(below: rect)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/move_left_right.mov)
    @discardableResult
    public func move(below target: Point, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .bottom, padding: padding)
    }
    
    /// Move `self` above `target`.
    ///
    /// ```swift
    /// let dot = Dot()
    /// let rect = Rectangle(width: 4, height: 2)
    ///
    /// withAnimation {
    ///     dot.move(leftOf: rect)
    ///     dot.move(above: rect)
    ///     dot.move(rightOf: rect)
    ///     dot.move(below: rect)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/move_left_right.mov)
    @discardableResult
    public func move(above target: Point, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .top, padding: padding)
    }
    
    /// Move `self` to the left of `target`.
    ///
    /// ```swift
    /// let dot = Dot()
    /// let rect = Rectangle(width: 4, height: 2)
    ///
    /// withAnimation {
    ///     dot.move(leftOf: rect)
    ///     dot.move(above: rect)
    ///     dot.move(rightOf: rect)
    ///     dot.move(below: rect)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/move_left_right.mov)
    @discardableResult
    public func move(leftOf target: Point, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .left, padding: padding)
    }
    
    /// Move `self` to the right of `target`.
    ///
    /// ```swift
    /// let dot = Dot()
    /// let rect = Rectangle(width: 4, height: 2)
    ///
    /// withAnimation {
    ///     dot.move(leftOf: rect)
    ///     dot.move(above: rect)
    ///     dot.move(rightOf: rect)
    ///     dot.move(below: rect)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/move_left_right.mov)
    @discardableResult
    public func move(rightOf target: Point, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: .right, padding: padding)
    }
    
    /// Move `self` in reference to `target`.
    ///
    /// ```swift
    /// let dot = Dot()
    /// let rect = Rectangle(width: 4, height: 2)
    ///
    /// withAnimation {
    ///     dot.move(.left, of: rect)
    ///     dot.move(.up, of: rect)
    ///     dot.move(.right, of: rect)
    ///     dot.move(.down, of: rect)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/move_left_right.mov)
    @discardableResult
    public func move(_ direction: Direction, of target: MObject, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: direction, padding: padding)
    }
    
    /// Move `self` in reference to `target`.
    ///
    /// ```swift
    /// let dot = Dot()
    /// let rect = Rectangle(width: 4, height: 2)
    ///
    /// withAnimation {
    ///     dot.move(.left, of: rect)
    ///     dot.move(.up, of: rect)
    ///     dot.move(.right, of: rect)
    ///     dot.move(.down, of: rect)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/move_left_right.mov)
    @discardableResult
    public func move(_ direction: Direction, of target: Point, padding: Double = 0.25) -> AttachedAnimation {
        self.move(nextTo: target, placing: direction, padding: padding)
    }
    
}


extension MObject {
    
    /// Move `self` in reference to `target`.
    @discardableResult
    public func move(_ direction: Direction, of target: Projection<Point>, padding: Double = 0.25) -> AttachedAnimation {
        self.addUpdater(self.move(direction, of: target, padding: padding))
    }
}
