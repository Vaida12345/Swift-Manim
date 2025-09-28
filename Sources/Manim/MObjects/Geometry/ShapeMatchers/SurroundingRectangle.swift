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
    ///   - padding: The padding between the rectangle and the surrounded object.
    public init(_ base: MObject, stroke: Color? = nil, _ strokeWidth: Double? = nil, fill: Color? = nil, padding: Double = 0.25) {
        super.init("\(Self.self)", stroke: stroke, strokeWidth: strokeWidth, fill: fill, defaultColor: .yellow) { arguments in
            arguments.insert("", base._pythonObject, at: 0)
            arguments.append("buff", padding)
        }
    }
    
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, defaultColor: Color = .yellow, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, defaultColor: defaultColor, builder)
    }
    
}
