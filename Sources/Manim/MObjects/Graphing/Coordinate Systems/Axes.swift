//
//  Axes.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/17.
//

import PythonKit


/// Creates a set of axes.
///
/// The axes always span the entire screen.
///
/// ```swift
/// let axes = Axes()
/// ```
///
/// ![Preview](Axes)
///
/// - SeeAlso: ``NumberPlane``
public class Axes: Group {
    
    /// Creates a set of axes.
    ///
    /// Note that the axes coordinate space is the same as global coordinate space.
    ///
    /// - Parameters:
    ///   - domain: The `(x_min, x_max, x_step)` values of the x-axis.
    ///   - range: The `(y_min, y_max, y_step)` values of the y-axis.
    ///   - width: The width of the axes in global coordinate space
    ///   - height: The height of the axes in global coordinate space
    public init(
        domain: Range? = nil,
        range: Range? = nil,
        width: Double? = nil,
        height: Double? = nil,
        xStyle: NumberLine.DisplayStyle = [.tip, .ticks],
        yStyle: NumberLine.DisplayStyle = [.tip, .ticks]
    ) {
        var args: Closure.Arguments = [
            ("x_range", domain?._adjustForTip(hasTip: xStyle.contains(.tip))),
            ("y_range", range?._adjustForTip(hasTip: yStyle.contains(.tip))),
            ("x_length", width?.pythonObject ?? manim.config.frame_width),
            ("y_length", height?.pythonObject ?? manim.config.frame_height)
        ]
        
        let x_config = [
            "include_ticks" : xStyle.contains(.ticks),
            "include_numbers" : xStyle.contains(.numbers),
            "include_tip" : xStyle.contains(.tip)
        ]
        
        let y_config = [
            "include_ticks" : yStyle.contains(.ticks),
            "include_numbers" : yStyle.contains(.numbers),
            "include_tip" : yStyle.contains(.tip)
        ]
        
        args.append("x_axis_config", x_config)
        args.append("y_axis_config", y_config)
        
        super.init(_pythonObject: manim.Axes.dynamicallyCall(withKeywordArguments: args))
    }
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, defaultColor: Color = .white, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, defaultColor: defaultColor, builder)
    }
    
}
