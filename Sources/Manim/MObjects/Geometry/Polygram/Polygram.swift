//
//  Polygram.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


/// A generalized ``Polygon``, allowing for disconnected sets of edges.
///
/// ```swift
/// NumberPlane().show()
/// Polygram(
///     vertices: [[0, 2, 0], [-sqrt(3), -1, 0], [sqrt(3), -1, 0]],
///     [[-sqrt(3), 1, 0], [0, -2, 0], [sqrt(3), 1, 0]]
/// ).show()
/// ```
///
/// ![Preview](Polygram)
public class Polygram: VMObject {
    
    /// Creates a polygram by connecting the dots in sequence.
    ///
    /// - Parameters:
    ///   - vertices: The dots among which will be connected. See discussion.
    ///   - stroke: The color used for the shape's outline.
    ///   - strokeWidth: The width of the outline stroke, in points. The default stroke with is `4`.
    ///   - fill: The color used to fill the shape's interior.
    ///
    /// If `stroke` or `fill` are not specified, a default style will be applied with no `fill` and a ``Color/white`` `stroke`.
    ///
    /// ## vertices
    ///
    /// Each group of points should form a closed loop.
    ///
    /// ```swift
    /// Polygram(
    ///     vertices: [[0, 2, 0], [-sqrt(3), -1, 0], [sqrt(3), -1, 0]],
    ///     [[-sqrt(3), 1, 0], [0, -2, 0], [sqrt(3), 1, 0]]
    /// ).show()
    /// ```
    ///
    /// ![Preview](Polygram)
    public init(vertices: [Point]..., stroke: Color? = nil, _ strokeWidth: Double? = nil, fill: Color? = nil) {
        super.init("\(Self.self)", stroke: stroke, strokeWidth: strokeWidth, fill: fill) { arguments in
            for (i, vertex) in vertices.enumerated() {
                arguments.insert("", vertex, at: i)
            }
        }
    }
    
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, defaultColor: Color = .white, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, defaultColor: defaultColor, builder)
    }
    
}

extension Polygram {
    
    /// Rounds off the corners of the Polygram.
    ///
    /// - Parameters:
    ///   - radius: The curvature of the corners of the Polygram.
    ///
    /// ```swift
    /// let polygram = Polygram(
    ///     vertices: [[0, 2, 0], [-sqrt(3), -1, 0], [sqrt(3), -1, 0]],
    ///     [[-sqrt(3), 1, 0], [0, -2, 0], [sqrt(3), 1, 0]]
    /// )
    /// polygram.cornerRadius(0.2)
    /// ```
    ///
    /// ![Preview](cornerRadius)
    @discardableResult
    public func cornerRadius(_ radius: Double) -> AttachedAnimation {
        AttachedAnimation(base: self, closure: Closure("round_corners", [("", radius)]))
    }
    
}
