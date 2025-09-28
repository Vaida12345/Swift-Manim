//
//  Cross.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//

import PythonKit

/// Creates a cross mark.
///
/// ```swift
/// let cross = Cross()
/// ```
///
/// ![Preview](Cross)
public final class Cross: Group {
    
    /// Creates a cross.
    ///
    /// - Parameters:
    ///   - color: The stroke color
    ///   - width: The stroke width
    public init(color: Color = .red, width: Double = 6) {
        super.init(_pythonObject: manim.Cross(stroke_color: color, stroke_width: width))
    }
    
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, defaultColor: Color = .white, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, defaultColor: defaultColor, builder)
    }
    
}
