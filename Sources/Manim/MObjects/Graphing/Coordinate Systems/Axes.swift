//
//  Axes.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/17.
//

import PythonKit


/// Creates a set of axes.
public class Axes: Group {
    
    public convenience init(domain: ClosedRange<Double>, range: ClosedRange<Double>) {
        self.init(domain: Range(domain), range: Range(range))
    }
    
    /// Creates a set of axes.
    ///
    /// Note that the axes coordinate space is the same as global coordinate space.
    ///
    /// - Parameters:
    ///   - domain: The `(x_min, x_max, x_step)` values of the x-axis.
    ///   - range: The `(y_min, y_max, y_step)` values of the y-axis.
    public init(domain: Range? = nil, range: Range? = nil) {
        let args: Closure.Arguments = [
            ("x_range", domain),
            ("y_range", range),
            ("x_length", manim.config.frame_width),
            ("y_length", manim.config.frame_height)
        ]
        
        super.init(manim.Axes.dynamicallyCall(withKeywordArguments: args))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
    
    /// Accepts coordinates and returns a point with respect to the `destination`.
    public func convert(_ point: Point, from source: CoordinateSpace, to destination: CoordinateSpace) -> Point {
        switch (source, destination) {
        case (.canvas, .axis):
            Point(self.pythonObject.coords_to_point(point))!
        case (.axis, .canvas):
            Point(self.pythonObject.point_to_coords(point))!
        default:
            point
        }
    }
    
    
    public enum CoordinateSpace {
        /// The coordinate on the canvas, ie, the ``SceneProxy``.
        case canvas
        
        /// The coordinate on the ``Axes``.
        case axis
    }
    
}
