//
//  SurroundingRectangle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//

import PythonKit


/// A rectangle surrounding an object
///
/// ```swift
/// let hex = RegularPolygon(n: 6, fill: .blue)
/// let rect = SurroundingRectangle(hex)
/// rect.color = .yellow
/// ```
///
/// ![Preview](SurroundingRectangle)
public class SurroundingRectangle: Rectangle {
    
    /// Creates the rectangle.
    ///
    /// - Parameters:
    ///   - base: The attached object.
    ///   - stroke: The color used for the shape's outline.
    ///   - strokeWidth: The width of the outline stroke, in points. The default stroke with is `4`.
    ///   - fill: The color used to fill the shape's interior.
    public init(_ base: MObject, stroke: Color? = nil, _ strokeWidth: Double? = nil, fill: Color? = nil) {
        super.init("\(Self.self)", stroke: stroke, strokeWidth: strokeWidth, fill: fill) { arguments in
            arguments.insert("", base.pythonObject, at: 0)
        }
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
