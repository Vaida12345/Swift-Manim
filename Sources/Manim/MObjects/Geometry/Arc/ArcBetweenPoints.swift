//
//  ArcBetweenPoints.swift
//  Manim
//
//  Created by Vaida on 2025-09-24.
//

import PythonKit


/// A circular Arc.
///
/// ```swift
/// let circle = Circle(radius: 2, stroke: .gray)
///
/// let dot1 = Dot(color: .green)
/// dot1.move(to: [2, 0])
/// dot1.scale(0.5)
///
/// let dot1Text = Text("(2,0)", color: .blue)
/// dot1Text.scale(0.5)
/// dot1Text.move(rightOf: dot1)
///
/// let dot2 = Dot(color: .green)
/// dot2.move(to: [0, 2])
/// dot2.scale(0.5)
///
/// let dot2Text = Text("(0,2)", color: .blue)
/// dot2Text.scale(0.5)
/// dot2Text.move(above: dot2)
///
/// let arc = ArcBetweenPoints(radius: 2, start: [2, 0], end: [0, 2])
/// scene.add(circle, dot1, dot2, dot1Text, dot2Text)
///
/// withAnimation {
///     arc.show(animation: .create)
/// }
/// ```
///
/// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/ArcBetweenPoints.mov)
public class ArcBetweenPoints: Arc {
    
    /// Creates an arc.
    ///
    /// - Parameters:
    ///   - radius: The radius of arc.
    ///   - start: The start angle.  When `start` is `0`, the line an arrow from (0, 0) to (1, 0)
    ///   - angle: The angle length.
    ///   - center: The center position.
    ///   - width: The stroke width.
    ///   - color: The stroke color.
    public init(radius: Double, start: Angle = .zero, angle: Angle, center: Point = .center, width: Double = 4, color: Color = .white) {
        let object = manim.ArcBetweenPoints(radius: radius, start_angle: start.radians, angle: angle.radians, arc_center: center, stroke_width: width, color: color)
        super.init(object)
    }
    
    /// Creates an arc.
    ///
    /// - Parameters:
    ///   - radius: The radius of arc.
    ///   - start: The starting point.
    ///   - end: The end point.
    ///   - angle: The degree of angle be between the central point to `start` and center to `end`.
    ///   - width: The stroke width.
    ///   - color: The stroke color.
    public init(radius: Double, start: Point, end: Point, angle: Angle = .degrees(45), width: Double = 4, color: Color = .white) {
        let object = manim.ArcBetweenPoints(radius: radius, start: start, end: end, angle: angle.radians, stroke_width: width, color: color)
        super.init(object)
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
