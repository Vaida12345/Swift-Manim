//
//  Dot.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import PythonKit


/// A dot
///
/// ```swift
/// let dot = Dot(color: .red)
/// ```
///
/// ![Preview](dot)
public final class Dot: Circle {
    
    /// Creates a dot
    ///
    /// - Parameters:
    ///   - point: The location of the dot.
    ///   - radius: The radius of the dot.
    ///   - color: The color of the dot.
    public init(at point: Point = .center, radius: Double = 0.08, color: Color = .white) {
        let object = manim.Dot(point: point, radius: radius, fill_opacity: color.alpha, color: color)
        super.init(_pythonObject: object)
    }
    
    /// Creates a dot
    ///
    /// - Parameters:
    ///   - point: The location of the dot.
    ///   - radius: The radius of the dot.
    ///   - color: The color of the dot.
    public init(at point: Projection<Point>, radius: Double = 0.08, color: Color = .white) {
        let object = manim.Dot(point: point.wrappedValue, radius: radius, fill_opacity: color.alpha, color: color)
        super.init(_pythonObject: object)
        
        self.addUpdater {
            self.move(to: point.wrappedValue)
        }
    }
    
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, defaultColor: Color = .white, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, defaultColor: defaultColor, builder)
    }
    
}
