//
//  TracedPath.swift
//  Manim
//
//  Created by Vaida on 2025-09-25.
//

import PythonKit


/// Traces the path of a point returned by a function call.
///
/// You can create this object directly, or use ``MObject/trace(_:color:width:dissipatingTime:)``.
///
/// ![Preview](trace)
///
/// ```swift
/// let dot = Dot(at: [2, 0])
/// let trace = dot.trace(\.center, dissipatingTime: 0.5)
/// scene.add(dot, trace)
///
/// withAnimation {
///     dot.shift(by: [-2, 0])
///         .path(.arc(.degrees(45)))
/// }
/// ```
public final class TracedPath: VMObject {
    
    /// Traces the path of a point returned by a function call.
    ///
    /// - Parameters:
    ///   - callable: The function to be traced.
    ///   - color: The color of the trace.
    ///   - width: The width of the trace.
    ///   - dissipatingTime: The time taken for the path to dissipate. Default set to `nil` which disables dissipation.
    ///
    /// - SeeAlso: ``MObject/trace(_:color:width:dissipatingTime:)``
    public init<T>(_ callable: @autoclosure @escaping () -> T, color: Color = .white, width: Double = 2, dissipatingTime: Double? = nil) where T: PythonConvertible {
        let method = PythonFunction { _ in
            return callable()
        }
        
        let opacity: PythonObject
        if color.alpha == 1 && dissipatingTime != nil {
            opacity = [1, 0]
        } else {
            opacity = color.alpha.pythonObject
        }
        
        super.init(manim.TracedPath(traced_point_func: method, stroke_width: width, stroke_opacity: opacity, stroke_color: color, dissipating_time: dissipatingTime))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}


extension MObject {
    
    /// Traces the path of a point returned by a function call.
    ///
    /// ![Preview](trace)
    ///
    /// ```swift
    /// let dot = Dot(at: [2, 0])
    /// let trace = dot.trace(\.center, dissipatingTime: 0.5)
    /// scene.add(dot, trace)
    ///
    /// withAnimation {
    ///     dot.shift(by: [-2, 0])
    ///         .path(.arc(.degrees(45)))
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - keyPath: The property to be traced.
    ///   - color: The color of the trace.
    ///   - width: The width of the trace.
    ///   - dissipatingTime: The time taken for the path to dissipate. Default set to `nil` which disables dissipation.
    public func trace<T>(_ keyPath: KeyPath<MObject, T> = \.center, color: Color? = nil, width: Double = 2, dissipatingTime: Double? = nil) -> TracedPath where T: PythonConvertible {
        TracedPath(self[keyPath: keyPath], color: color ?? self.color, width: width, dissipatingTime: dissipatingTime)
    }
    
}
