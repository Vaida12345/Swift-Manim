//
//  Path.swift
//  Manim
//
//  Created by Vaida on 2025-09-27.
//

import PythonKit


extension Transform {
    
    /// Functions determining transformation paths between sets of points.
    ///
    /// See below for examples.
    ///
    /// - ``Path/straight``
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Path_straight.mov)
    ///
    /// - ``Path/spiral(angle:axis:)``
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Path_spiral.mov)
    ///
    /// - ``Path/circle(at:angle:axis:)``
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Path_circle.mov)
    ///
    /// - ``Path/arc(angle:axis:)``
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Path_arc.mov)
    ///
    /// - ``Path/counterClockwise``
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Path_counterClockwise.mov)
    ///
    /// - ``Path/clockwise``
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Path_clockwise.mov)
    @MainActor
    public struct Path: PythonConvertible {
        
        public let pythonObject: PythonObject
        
        
        /// Simplest path function. Each point in a set goes in a straight path toward its destination.
        ///
        /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Path_straight.mov)
        ///
        /// ```swift
        /// let dot = Dot(at: [-2, 0], color: .red)
        /// let dest = Dot(at: [2, 0], color: .gray)
        /// scene.add(dest, dot, dot.trace())
        ///
        /// withAnimation {
        ///     dot.move(to: dest)
        ///         .path(.straight)
        /// }
        /// ```
        public static var straight: Path {
            self.init(pythonObject: manim.utils.paths.straight_path())
        }
        
        /// This function transforms each point by moving along a spiral to its destination.
        ///
        /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Path_spiral.mov)
        ///
        /// ```swift
        /// let dot = Dot(at: [-2, 0], color: .red)
        /// let dest = Dot(at: [2, 0], color: .gray)
        /// scene.add(dest, dot, dot.trace())
        ///
        /// withAnimation {
        ///     dot.move(to: dest)
        ///         .path(.spiral(angle: .degrees(360)))
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - angle: The angle each point traverses around a spiral.
        ///   - axis: The axis of rotation.
        public static func spiral(angle: Angle, axis: Axis = .z) -> Path {
            self.init(pythonObject: manim.utils.paths.spiral_path(angle: angle.radians, axis: axis))
        }
        
        /// This function transforms each point by moving it roughly along a circle, each with its own specified center.
        ///
        /// The path may be seen as each point smoothly changing its orbit from its starting position to its destination.
        ///
        /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Path_circle.mov)
        ///
        /// ```swift
        /// let dot = Dot(at: [-2, 0], color: .red)
        /// let dest = Dot(at: [2, 0], color: .gray)
        /// scene.add(dest, dot, dot.trace())
        ///
        /// withAnimation {
        ///     dot.move(to: dest)
        ///         .path(.circle(at: [-3, 0], angle: .degrees(360)))
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - center: The centers of each point’s quasicircle to rotate around.
        ///   - angle: The angle each point traverses around the quasicircle.
        ///   - axis: The axis of rotation.
        public static func circle(at center: Point, angle: Angle, axis: Axis = .z) -> Path {
            self.init(pythonObject: manim.utils.paths.path_along_circles(arc_angle: angle.radians, circles_centers: center, axis: axis))
        }
        
        /// This function transforms each point by moving it along a circular arc.
        ///
        /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Path_arc.mov)
        ///
        /// ```swift
        /// let dot = Dot(at: [-2, 0], color: .red)
        /// let dest = Dot(at: [2, 0], color: .gray)
        /// scene.add(dest, dot, dot.trace())
        ///
        /// withAnimation {
        ///     dot.move(to: dest)
        ///         .path(.arc(angle: .degrees(120)))
        /// }
        /// ```
        ///
        /// - Parameters:
        ///   - angle: The angle each point traverses around a circular arc.
        ///   - axis: The axis of rotation.
        public static func arc(angle: Angle, axis: Axis = .z) -> Path {
            self.init(pythonObject: manim.utils.paths.path_along_arc(arc_angle: angle.radians, axis: axis))
        }
        
        /// This function transforms each point by moving counterclockwise around a half circle.
        ///
        /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Path_counterClockwise.mov)
        ///
        /// ```swift
        /// let dot = Dot(at: [-2, 0], color: .red)
        /// let dest = Dot(at: [2, 0], color: .gray)
        /// scene.add(dest, dot, dot.trace())
        ///
        /// withAnimation {
        ///     dot.move(to: dest)
        ///         .path(.counterClockwise)
        /// }
        /// ```
        public static var counterClockwise: Path {
            self.init(pythonObject: manim.utils.paths.counterclockwise_path())
        }
        
        /// This function transforms each point by moving clockwise around a half circle.
        ///
        /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Path_clockwise.mov)
        ///
        /// ```swift
        /// let dot = Dot(at: [-2, 0], color: .red)
        /// let dest = Dot(at: [2, 0], color: .gray)
        /// scene.add(dest, dot, dot.trace())
        ///
        /// withAnimation {
        ///     dot.move(to: dest)
        ///         .path(.clockwise)
        /// }
        /// ```
        public static var clockwise: Path {
            self.init(pythonObject: manim.utils.paths.clockwise_path())
        }
    }
    
}
