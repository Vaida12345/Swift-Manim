//
//  CutOut.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


/// A shape with smaller cutouts.
///
/// ```swift
/// let hex = RegularPolygon(n: 6)
/// hex.scale(1.5)
/// let circle = Circle()
/// let cutout = Cutout(hex, cutouts: circle, fill: .white)
///
/// scene.add(cutout)
/// ```
///
/// ![Preview](Cutout)
public final class Cutout: VMObject {
    
    /// Creates a shape.
    ///
    /// - Parameters:
    ///   - base: The primary shape from which cutouts are made.
    ///   - cutouts: The smaller shapes which are to be cut out of the `base`.
    ///   - stroke: The color used for the shape's outline.
    ///   - strokeWidth: The width of the outline stroke, in points. The default stroke with is `4`.
    ///   - fill: The color used to fill the shape's interior.
    ///
    /// If `stroke` or `fill` are not specified, a default style will be applied with no `fill` and a ``Color/white`` `stroke`.
    public init(_ base: VMObject, cutouts: [VMObject], stroke: Color? = nil, _ strokeWidth: Double? = nil, fill: Color? = nil) {
        super.init("\(Self.self)", stroke: stroke, strokeWidth: strokeWidth, fill: fill) { arguments in
            arguments.insert("", base._pythonObject, at: 0)
            for (i, object) in cutouts.enumerated() {
                arguments.insert("", object._pythonObject, at: 1 + i)
            }
        }
    }
    
    /// Creates a shape.
    ///
    /// - Parameters:
    ///   - base: The primary shape from which cutouts are made.
    ///   - cutouts: The smaller shapes which are to be cut out of the `base`.
    ///   - stroke: The color used for the shape's outline.
    ///   - strokeWidth: The width of the outline stroke, in points. The default stroke with is `4`.
    ///   - fill: The color used to fill the shape's interior.
    ///
    /// If `stroke` or `fill` are not specified, a default style will be applied with no `fill` and a ``Color/white`` `stroke`.
    public convenience init(_ base: VMObject, cutouts: VMObject..., stroke: Color? = nil, _ strokeWidth: Double? = nil, fill: Color? = nil) {
        self.init(base, cutouts: cutouts, stroke: stroke, strokeWidth, fill: fill)
    }
    
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, defaultColor: Color = .white, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, defaultColor: defaultColor, builder)
    }
    
}


extension VMObject {
    
    /// Creates a cutout using the given sub objects.
    ///
    /// ```swift
    /// let hex = RegularPolygon(n: 6)
    /// hex.scale(1.5)
    /// let circle = Circle()
    /// let cutout = hex.cutout(circle)
    /// cutout.fill(.white)
    ///
    /// scene.add(cutout)
    /// ```
    ///
    /// ![Preview](Cutout)
    public func cutout(_ objects: [VMObject]) -> Cutout {
        Cutout(self, cutouts: objects)
    }
    
    /// Creates a cutout using the given sub objects.
    ///
    /// ```swift
    /// let hex = RegularPolygon(n: 6)
    /// hex.scale(1.5)
    /// let circle = Circle()
    /// let cutout = hex.cutout(circle)
    /// cutout.fill(.white)
    ///
    /// scene.add(cutout)
    /// ```
    ///
    /// ![Preview](Cutout)
    public func cutout(_ objects: VMObject...) -> Cutout {
        self.cutout(objects)
    }
    
}
