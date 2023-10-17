//
//  Axes.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/17.
//



/// Creates a set of axes.
public class Axes: VGroup {
    
    /// Creates a set of axes.
    ///
    /// - Parameters:
    ///   - domain: The `(x_min, x_max, x_step)` values of the x-axis.
    ///   - range: The `(y_min, y_max, y_step)` values of the y-axis.
    ///   - length: The length of the `(x, y)`-axis.
    ///   - style: The style of axes.
    ///   - dimensions: The dimension.
    public init(domain: NumberLine.Range? = nil,
                range: NumberLine.Range? = nil,
                length: (x: Double?, y: Double?)? = nil,
                style: Style? = nil,
                dimensions: Int? = nil) {
        var args = [
            ("x_range", domain?.pyDescription),
            ("y_range", range?.pyDescription),
            ("x_length", length?.x?.description),
            ("dimensions", dimensions?.description)
        ]
        switch style {
        case .__both(let numberLine):
            args.append(("axis_config", numberLine.__args?.pyDescription))
        case .__individual(let x, let y):
            args.append(("x_axis_config", x.__args?.pyDescription))
            args.append(("y_axis_config", y.__args?.pyDescription))
        case nil:
            break
        }
        
        super.init(args: args)
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    
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
    
}
