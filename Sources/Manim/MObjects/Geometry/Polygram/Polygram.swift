//
//  Polygram.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


/// A generalized Polygon, allowing for disconnected sets of edges.
public class Polygram: VMObject {
    
    /// Creates a polygram by connecting the dots in sequence.
    ///
    /// - Parameters:
    ///   - vertices: The dots among which will be connected.
    ///   - stroke: The color used for the shape's outline.
    ///   - strokeWidth: The width of the outline stroke, in points. The default stroke with is `4`.
    ///   - fill: The color used to fill the shape's interior.
    ///
    /// If `stroke` or `fill` are not specified, a default style will be applied with no `stroke` and a `fill` color of ``Color/blue``.
    public convenience init(vertices: [Point], stroke: Color? = nil, _ strokeWidth: Double? = nil, fill: Color? = nil) {
        self.init("\(Self.self)", stroke: stroke, strokeWidth: strokeWidth, fill: fill) { arguments in
            arguments.insert("", vertices, at: 0)
        }
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}

extension Polygram {
    
    /// Rounds off the corners of the Polygram.
    ///
    /// - Parameters:
    ///   - radius: The curvature of the corners of the Polygram.
    public func cornerRadius(_ radius: Double) -> AttachedAnimation {
        AttachedAnimation(base: self.pythonObject, closure: Closure("round_corners", [("", radius)]))
    }
    
}
