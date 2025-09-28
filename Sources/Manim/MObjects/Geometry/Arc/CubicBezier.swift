//
//  CubicBezier.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import PythonKit


/// A cubic Bézier curve.
///
/// ```swift
/// let dot1 = Dot(at: [-3, 1], color: .blue)
/// let dot2 = Dot(at: [3, -1], color: .red)
/// let bezier = CubicBezier(start: .init(anchor: dot1.center, handle: dot1.center + [3, 0]), end: .init(anchor: dot2.center, handle: dot2.center - [3, 0]))
/// scene.add(dot1, dot2, bezier)
/// ```
///
/// ![Preview](CubicBezier)
public final class CubicBezier: VMObject {
    
    /// Creates a bezier using the coordinates of `anchor` and `handle`.
    ///
    /// Initializes a cubic Bézier curve with the given start and end controls, stroke width, and color.
    ///
    /// - Parameters:
    ///   - start: A `Control` containing the start anchor and its handle, defining the curve’s entry point and tangent.
    ///   - end: A `Control` containing the end anchor and its handle, defining the curve’s exit point and tangent.
    ///   - width: The stroke width of the curve.
    ///   - color: The stroke color of the curve.
    ///
    /// ```swift
    /// let dot1 = Dot(at: [-3, 1], color: .blue)
    ///
    /// let handle1 = dot1.center + [3, 0]
    /// let control = CubicBezier.Control(anchor: dot1.center, handle: handle1)
    ///
    /// let bezier = CubicBezier(start: control, end: .init(anchor: [3, -1], handle: [3, -1]))
    /// scene.add(dot1, bezier)
    /// scene.add(Dot(at: handle1, color: .gray), Line(from: dot1.center, to: handle1, color: .gray))
    /// ```
    ///
    /// ![Preview](CubicBezier_Control)
    public init(start: Control, end: Control, width: Double = 4, color: Color = .white) {
        super.init(_pythonObject: manim.CubicBezier(start_anchor: start.anchor, start_handle: start.handle, end_anchor: end.anchor, end_handle: end.handle, stroke_width: width, color: color))
    }
    
    /// A control point for cubic Bézier curve.
    ///
    /// ```swift
    /// let dot1 = Dot(at: [-3, 1], color: .blue)
    ///
    /// let handle1 = dot1.center + [3, 0]
    /// let control = CubicBezier.Control(anchor: dot1.center, handle: handle1)
    ///
    /// let bezier = CubicBezier(start: control, end: .init(anchor: [3, -1], handle: [3, -1]))
    /// scene.add(dot1, bezier)
    /// scene.add(Dot(at: handle1, color: .gray), Line(from: dot1.center, to: handle1, color: .gray))
    /// ```
    ///
    /// ![Preview](CubicBezier_Control)
    public struct Control {
        
        let anchor: Point, handle: Point
        
        
        /// Initializes a `Control` point for constructing a cubic Bézier curve.
        ///
        /// - Parameters:
        ///   - anchor: The main point through which the curve will pass.
        ///   - handle: The control handle that influences the tangent and curvature at the anchor.
        ///
        /// ```swift
        /// let dot1 = Dot(at: [-3, 1], color: .blue)
        ///
        /// let handle1 = dot1.center + [3, 0]
        /// let control = CubicBezier.Control(anchor: dot1.center, handle: handle1)
        ///
        /// let bezier = CubicBezier(start: control, end: .init(anchor: [3, -1], handle: [3, -1]))
        /// scene.add(dot1, bezier)
        /// scene.add(Dot(at: handle1, color: .gray), Line(from: dot1.center, to: handle1, color: .gray))
        /// ```
        ///
        /// ![Preview](CubicBezier_Control)
        public init(anchor: Point, handle: Point) {
            self.anchor = anchor
            self.handle = handle
        }
        
    }
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
