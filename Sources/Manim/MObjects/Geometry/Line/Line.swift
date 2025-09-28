//
//  Line.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import OSLog
import PythonKit
import SwiftUI


/// A line.
///
/// ```swift
/// let line = Line(from: [-1, -1], to: [1, 1], width: 6)
/// line.capStyle = .round
/// ```
///
/// ![Preview](Line)
public class Line: TipableVMObject {
    
    /// Creates a Line.
    ///
    /// - Parameters:
    ///   - start: The starting point of the line.
    ///   - end: The ending point of the line.
    ///   - width: The stroke width.
    ///   - color: The stroke color.
    ///   - padding: The paddings between the line and `start`, `end`.
    public init(from start: Point, to end: Point, width: Double = 4, color: Color = .white, padding: Double = 0) {
        super.init(manim.Line(start: start, end: end, stroke_width: width, color: color, buff: padding))
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}


extension Line {
    
    /// Moves the ``MObject/start`` and ``MObject/end``.
    ///
    /// ```swift
    /// let dot1 = Dot(color: .blue)
    /// let dot2 = Dot(color: .green)
    ///
    /// scene.arrange(dot1, dot2, direction: .right)
    ///
    /// let line = Line(from: dot1.center, to: dot2.center, color: .red)
    /// line.addUpdater(initialCall: true) {
    ///     line.moveTo(start: dot1.center, end: dot2.center)
    /// }
    ///
    /// scene.add(dot1, dot2, line)
    ///
    /// let x = dot1.track(\.x)
    /// let y = dot2.track(\.y)
    ///
    /// withAnimation {
    ///     x += 4
    ///     y += 4
    /// }
    /// ```
    ///
    /// ![video](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/MovingDots.mov)
    @discardableResult
    public func moveTo(start: Point, end: Point) -> AttachedAnimation {
        AttachedAnimation(base: self._transformable, closure: Closure("put_start_and_end_on", [("", start), ("", end)]))
    }
    
    /// Moves the ``MObject/start`` and ``MObject/end``.
    ///
    /// ```swift
    /// let dot1 = Dot(color: .blue)
    /// let dot2 = Dot(color: .green)
    ///
    /// scene.arrange(dot1, dot2, direction: .right)
    ///
    /// let line = Line(from: dot1.center, to: dot2.center, color: .red)
    /// line.moveTo(start: dot1.track(\.center), end: dot2.track(\.center))
    ///
    /// scene.add(dot1, dot2, line)
    ///
    /// let x = dot1.track(\.x)
    /// let y = dot2.track(\.y)
    ///
    /// withAnimation {
    ///     x += 4
    ///     y += 4
    /// }
    /// ```
    ///
    /// ![video](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/MovingDots.mov)
    @discardableResult
    public func moveTo(start: Projection<Point>, end: Projection<Point>) -> AttachedAnimation {
        self.addUpdater(AttachedAnimation(base: self._transformable, closure: Closure("put_start_and_end_on", [("", start.wrappedValue), ("", end.wrappedValue)])))
    }
    
}
