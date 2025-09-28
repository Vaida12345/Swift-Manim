//
//  Arc.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import Foundation
import PythonKit


/// A circular arc.
///
/// ```swift
/// let arc = Arc(angle: .degrees(180))
/// scene.add(arc)
/// ```
///
/// ![Preview](arc)
///
/// An arc always choose to connect from the shortest side.
///
/// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Moving_Angle.mov)
public class Arc: TipableVMObject {
    
    /// Creates an arc.
    ///
    /// - Parameters:
    ///   - radius: The radius of arc.
    ///   - startAngle: The start angle. When `start` is `0`, the line an arrow from (0, 0) to (1, 0)
    ///   - angle: The angle length.
    ///   - center: The center position.
    ///   - width: The stroke width.
    ///   - color: The stroke color.
    public init(radius: Double = 1, startAngle: Angle = .zero, angle: Angle, center: Point = .center, width: Double = 4, color: Color = .white) {
        let object = manim.Arc(radius: radius, start_angle: startAngle.radians, angle: angle.radians, arc_center: center, stroke_width: width, color: color)
        super.init(_pythonObject: object)
    }
    
    /// Creates an arc.
    ///
    /// - Parameters:
    ///   - start: The starting point.
    ///   - end: The end point.
    ///   - angle: The degree of angle be between the central point to `start` and center to `end`.
    ///   - width: The stroke width.
    ///   - color: The stroke color.
    public init(start: Point, end: Point, angle: Angle = .degrees(45), width: Double = 4, color: Color = .white) {
        let object = manim.Arc(start: start, end: end, angle: angle.radians, stroke_width: width, color: color)
        super.init(_pythonObject: object)
    }
    
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}


extension Arc {
    
    /// The stop angle.
    public var stopAngle: Angle {
        Angle(self._pythonObject.stop_angle())!
    }
    
    /// The start angle.
    public var startAngle: Angle {
        get { Angle(self._pythonObject.start_angle)! }
        set { self._pythonObject.start_angle = newValue.pythonObject }
    }
    
    
    /// The origin point.
    ///
    /// For ``Arc``, the origin is the arc center.
    ///
    /// ![Preview](Arc_origin)
    ///
    /// ```swift
    /// let arc = Arc(angle: .degrees(135))
    /// let text = Text("origin: \(arc.origin.description)", fontSize: 36)
    /// text.move(.bottomLeft, of: arc.origin)
    /// let dot = Dot(at: arc.origin)
    /// scene.add(arc, text, dot)
    /// ```
    public var origin: Point {
        get { Point(self._pythonObject.get_arc_center())! }
        set { self._pythonObject.move_arc_center_to(point: newValue) }
    }
    
    /// Moves ``origin`` to the given point.
    ///
    /// ```swift
    /// let arc = Arc(angle: .degrees(135))
    /// let text = Text("origin: \(arc.origin.description)", fontSize: 36)
    /// text.addUpdater {
    ///     text.become(Text("origin: \(arc.origin.description)", fontSize: 36))
    ///     text.move(.bottomLeft, of: arc.origin)
    /// }
    /// let dot = Dot(at: arc.track(\.origin))
    /// scene.add(arc, text, dot)
    ///
    /// withAnimation {
    ///     arc.move(to: [1, 1])
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Arc_move.mov)
    @discardableResult
    public func move(to target: Point) -> AttachedAnimation {
        var closure = Closure(name: "move_arc_center_to")
        closure.append("point", target)
        return AttachedAnimation(base: self, closure: closure)
    }
    
    /// Moves ``origin`` to the given point.
    ///
    /// ```swift
    /// let arc = Arc(angle: .degrees(135))
    /// let text = Text("origin: \(arc.origin.description)", fontSize: 36)
    /// text.addUpdater {
    ///     text.become(Text("origin: \(arc.origin.description)", fontSize: 36))
    ///     text.move(.bottomLeft, of: arc.origin)
    /// }
    /// let dot = Dot(at: arc.track(\.origin))
    /// scene.add(arc, text, dot)
    ///
    /// withAnimation {
    ///     arc.move(to: [1, 1])
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Arc_move.mov)
    @discardableResult
    public func move(to target: Projection<Point>) -> AttachedAnimation {
        self.addUpdater(self.move(to: target))
    }
    
}
