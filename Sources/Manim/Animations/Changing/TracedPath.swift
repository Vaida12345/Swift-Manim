//
//  TracedPath.swift
//  Manim
//
//  Created by Vaida on 2025-09-25.
//

import PythonKit


/// Traces the path of a point returned by a function call.
public final class TracedPath: VMObject {
    
    /// - Parameters:
    ///   - function: The function to be traced.
    ///   - color: The color of the trace.
    ///   - width: The width of the trace.
    ///   - dissipatingTime: The time taken for the path to dissipate. Default set to `nil` which disables dissipation.
    public init<T>(_ callable: @autoclosure @escaping () -> T, color: Color = .white, width: Double = 2, dissipatingTime: Double? = nil) where T: PythonConvertible {
        let method = PythonFunction { _ in
            callable()
        }
        
        super.init(manim.TracedPath(traced_point_func: method, stroke_width: width, stroke_opacity: color.alpha, stroke_color: color, dissipating_time: dissipatingTime))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}


//traced_point_func (Callable) – The function to be traced.
//stroke_width (float) – The width of the trace.
//stroke_color (ParsableManimColor | None) – The color of the trace.
//dissipating_time (float | None) – The time taken for the path to dissipate. Default set to None which disables dissipation.
