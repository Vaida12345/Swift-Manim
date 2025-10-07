//
//  Axes + Methods.swift
//  Manim
//
//  Created by Vaida on 2025-09-26.
//

import PythonKit


extension Axes {
    
    /// Generates a curve based on a function on `self`.
    ///
    /// Plots a 2D curve on these axes by sampling a Swift closure and converting it into a Manim function graph.
    ///
    /// - Parameters:
    ///   - color: The color to draw the curve. Defaults to `.yellow`.
    ///   - range: An optional `Range` specifying the interval of x-values over which to evaluate the closure.
    ///   - function: A closure that maps each x-value (`Double`) to a y-value (`Double`), defining the shape of the curve.
    ///
    /// - Returns: The resulting ``ParametricFunction``.
    ///
    /// ```swift
    /// let axes = Axes()
    /// let function = axes.plot(range: Range(-5...5)) { x in
    ///     sin(x)
    /// }
    /// scene.add(axes, function)
    /// ```
    ///
    /// ![Preview](Axes_plot)
    public func plot(color: Color = .yellow, range: Range? = nil, function: @escaping (Double) -> Double) -> ParametricFunction {
        let function = PythonFunction { object in
            function(Double(object)!)
        }
        
        return ParametricFunction(_pythonObject: manim.FunctionGraph(function, color: color, x_range: range))
    }
    
    /// Returns the angle to the x-axis of the tangent to the plotted curve at a particular x-value.
    ///
    /// - Parameters:
    ///   - x: The x-value at which the tangent must touch the curve.
    ///   - function: The function for which to calculate the tangent.
    public func tangentAngle(of function: ParametricFunction, at x: Double) -> Double {
        Double(self._pythonObject.angle_of_tangent(x, function._pythonObject))!
    }
    
    /// Returns the slope of the tangent to the plotted curve at a particular x-value.
    ///
    /// - Parameters:
    ///   - x: The x-value at which the tangent must touch the curve.
    ///   - function: The function for which to calculate the tangent.
    public func tangentSlope(of function: ParametricFunction, at x: Double) -> Double {
        Double(self._pythonObject.slope_of_tangent(x, function._pythonObject))!
    }
    
    /// Creates a labelled triangle marker with a vertical line from the x-axis to a curve at a given x-value.
    ///
    /// - Parameters:
    ///   - xValue: The position along the curve at which the label, line and triangle will be constructed.
    ///   - function: The ParametricFunction for which to construct the label.
    ///   - label: The label of the vertical line and triangle.
    ///   - color: The color of the triangle and the vertical line.
    ///
    /// - Returns: The resulting ``Group`` containing the label, triangle, and vertical line.
    ///
    /// ```swift
    /// let axes = Axes()
    /// let function = axes.plot(function: sin)
    /// let label = axes.label(xValue: 1.5, of: function)
    /// scene.add(axes, function, label)
    /// ```
    ///
    /// ![Preview](Axes_label)
    public func label(xValue: Double, of function: ParametricFunction, label: String? = nil, color: Color = .white) -> Group {
        Group(_pythonObject: self._pythonObject.get_T_label(x_val: xValue, graph: function._pythonObject, label: label ?? xValue.description, triangle_color: color, line_color: color))
    }
    
    /// Returns a Polygon representing the area under the graph passed.
    ///
    /// - Parameters:
    ///   - range: The range of the minimum and maximum x-values of the area
    ///   - function: The graph/curve for which the area needs to be gotten.
    ///   - secondFunction: If a secondary graph is specified, encloses the area between the two curves.
    ///   - color: The color of the area
    ///
    /// - Returns: The Polygon representing the area.
    ///
    /// ```swift
    /// let axes = Axes()
    /// let function = axes.plot(function: sin)
    /// let area = axes.integral(1...6, of: function)
    /// scene.add(axes, function, area)
    /// ```
    ///
    /// ![Preview](Axes_integral)
    public func integral(_ range: ClosedRange<Double>, of function: ParametricFunction, _ secondFunction: ParametricFunction? = nil, color: Color = .green.opacity(0.3)) -> Polygon {
        Polygon(_pythonObject: self._pythonObject.get_area(graph: function._pythonObject, x_range: [range.lowerBound, range.upperBound], color: color, opacity: color.alpha, bounded_graph: secondFunction?._pythonObject))
    }
    
    /// Creates a properly positioned label & dot for the passed graph.
    ///
    /// - Parameters:
    ///   - x: The x value along the curve that positions the label.
    ///   - function: The curve.
    ///   - label: The label for the function’s curve.
    ///   - color: The color of the label. Defaults to the color of the curve.
    ///
    /// - Returns: The positioned label and Dot, if applicable.
    ///
    /// ```swift
    /// let axes = Axes()
    /// let function = axes.plot(function: sin)
    /// let label = axes.label(pointAt: 2, of: function)
    /// scene.add(axes, function, label)
    /// ```
    ///
    /// ![Preview](Axes_label_pointAt)
    public func label(pointAt x: Double, of function: ParametricFunction, label: String? = nil, color: Color? = nil) -> Group {
        let y = function(x)
        return Group(_pythonObject: self._pythonObject.get_graph_label(graph: function._pythonObject, label: label ?? "(\(x.userFriendlyDescription), \(y.userFriendlyDescription))", x_val: x, color: color, direction: numpy.array([x, y, 0]), dot: true))
    }
    
    /// Generate both horizontal and vertical lines from the axis to a point.
    ///
    /// - Parameters:
    ///   - point: A point on the scene.
    ///   - width: The stroke width
    ///   - color: The color of the lines.
    ///
    /// ```swift
    /// let axes = Axes()
    /// let function = axes.plot(function: sin)
    /// let line = axes.makeLines(to: Point(x: 2, y: function(2)))
    /// scene.add(axes, function, line)
    /// ```
    ///
    /// ![Preview](Axes_makeLines)
    public func makeLines(to point: Point, width: Double = 2, color: Color = .white) -> Group {
        return Group(_pythonObject: self._pythonObject.get_lines_to_point(point: point, stroke_width: width, color: color))
    }
    
    /// Accepts coordinates and returns a point with respect to the `destination`.
    public func convert(_ point: Point, from source: CoordinateSpace, to destination: CoordinateSpace) -> Point {
        switch (source, destination) {
        case (.canvas, .axis):
            Point(self._pythonObject.point_to_coords(point))!
        case (.axis, .canvas):
            Point(self._pythonObject.coords_to_point.dynamicallyCall(withArguments: [point.x, point.y, point.z]))!
        default:
            point
        }
    }
    
    
    
    /// CoordinateSpace defines the reference frame used when interpreting or converting
    /// a point’s coordinates in an `Axes` context.
    ///
    /// - canvas:
    ///   The point is given in canvas (scene) coordinates, relative to the overall
    ///   drawing surface (e.g., the `SceneProxy`).
    ///
    /// - axis:
    ///   The point is given in axis coordinates, relative to the `Axes` object itself,
    ///   where the origin and scaling are defined by the axes system.
    public enum CoordinateSpace {
        
        /// The coordinate on the canvas, ie, the ``SceneProxy``.
        case canvas
        
        /// The coordinate on the ``Axes``.
        case axis
    }
    
}
