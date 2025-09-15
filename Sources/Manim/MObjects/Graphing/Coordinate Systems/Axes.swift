//
//  Axes.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/17.
//



/// Creates a set of axes.
public class Axes: VGroup {
    
    public convenience init(domain: ClosedRange<Double>, range: ClosedRange<Double>) {
        self.init(domain: NumberLine.Range(min: domain.lowerBound, max: domain.upperBound),
                  range: NumberLine.Range(min: range.lowerBound, max: range.upperBound))
    }
    
    /// Creates a set of axes.
    ///
    /// Note that the axes coordinate space is the same as global coordinate space.
    ///
    /// - Parameters:
    ///   - domain: The `(x_min, x_max, x_step)` values of the x-axis.
    ///   - range: The `(y_min, y_max, y_step)` values of the y-axis.
    ///   - style: The style of axes.
    ///   - dimensions: The dimension, defaults to 2.
    public init(domain: NumberLine.Range? = nil,
                range: NumberLine.Range? = nil,
                style: Style? = nil,
                dimensions: Int? = nil) {
        var args: Closure.Arguments = [
            ("x_range", domain?.representation),
            ("y_range", range?.representation),
            ("x_length", "config.frame_width"),
            ("y_length", "config.frame_height"),
            ("dimensions", dimensions?.description)
        ]
        switch style {
        case .__both(let numberLine):
            args.append("axis_config", numberLine.__args?.representation)
        case .__individual(let x, let y):
            args.append("x_axis_config", x.__args?.representation)
            args.append("y_axis_config", y.__args?.representation)
        case nil:
            break
        }
        
        super.init(args: args)
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    
    
    /// Accepts coordinates and returns a point with respect to the `destination`.
    public func convert(_ point: Point, from source: CoordinateSpace, to destination: CoordinateSpace) -> Point {
        switch (source, destination) {
        case (.canvas, .axis):
            Generator.main.assign(type: Point.self, by: self, calling: "coords_to_point", args: [(nil, point.representation)])
        case (.axis, .canvas):
            Generator.main.assign(type: Point.self, by: self, calling: "point_to_coords", args: [(nil, point.representation)])
        default:
            fatalError("You're trying to convert a coordinate space to itself, this could be a logic error.")
        }
    }
    
    public enum Style {
        case __both(NumberLine)
        case __individual(x: NumberLine, y: NumberLine)
        
        public static func both(_ style: @autoclosure () -> NumberLine) -> Style {
            shouldOverrideInit = true
            defer { shouldOverrideInit = false }
            return .__both(style())
        }
        
        public static func individual(x: @autoclosure () -> NumberLine, y: @autoclosure () -> NumberLine) -> Style {
            shouldOverrideInit = true
            defer { shouldOverrideInit = false }
            return .__individual(x: x(), y: y())
        }
    }
    
    
    public enum CoordinateSpace {
        /// The coordinate on the canvas, ie, the ``Scene``.
        case canvas
        
        /// The coordinate on the ``Axes``.
        case axis
    }
    
}
