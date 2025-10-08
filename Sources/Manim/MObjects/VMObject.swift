//
//  VMObject.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import PythonKit


/// Vectorized Mathematical Object.
///
/// Many concrete classes inherit from `VMObject`. You do not create instances directly from this abstract class; instead, you create instances of concrete classes that inherit the properties and methods of `VMObject`.
///
/// ```swift
/// let rect = Rectangle(width: 4, height: 2)
/// rect.stroke(.white, width: 6)
/// rect.fill(.white.opacity(0.5))
/// rect.show()
/// ```
///
/// ![Preview](rect)
@MainActor
public class VMObject: @MainActor MObject {
    
    public var _pythonObject: PythonKit.PythonObject
    
    
    /// Expected initializer for most `VMObjects`.
    ///
    /// Any object with a meaningful differentiation between `stroke` and `fill` should have this signature in the initializer, right after parameters for sizing.
    ///
    /// - Parameters:
    ///   - stroke: The color used for the shape's outline.
    ///   - strokeWidth: The width of the outline stroke, in points. The default stroke with is `4`.
    ///   - fill: The color used to fill the shape's interior.
    ///
    /// If `stroke` or `fill` are not specified, a default style will be applied with no `fill` and a ``Color/white`` `stroke`.
    convenience init(stroke: Color? = nil, _ strokeWidth: Double? = nil, fill: Color? = nil) {
        self.init("VMObject", stroke: stroke, strokeWidth: strokeWidth, fill: fill) { arguments in
            
        }
    }
    
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, defaultColor: Color = .white, _ builder: (inout Closure.Arguments) -> Void) {
        var closure = Closure(name)
        if let stroke, let strokeWidth, let fill {
            closure.append("stroke_color", stroke)
            closure.append("stroke_opacity", stroke.alpha)
            closure.append("stroke_width", strokeWidth)
            closure.append("fill_color", fill)
            closure.append("fill_opacity", fill.alpha)
        } else if let stroke {
            closure.append("stroke_color", stroke)
            closure.append("stroke_opacity", stroke.alpha)
            closure.append("stroke_width", strokeWidth ?? 4)
            closure.append("fill_color", Python.None)
            closure.append("fill_opacity", 0) // no fill
        } else if let fill {
            closure.append("stroke_color", Python.None)
            closure.append("stroke_opacity", 0)
            closure.append("stroke_width", strokeWidth ?? 4)
            closure.append("fill_color", fill)
            closure.append("fill_opacity", fill.alpha)
        } else {
            // fall back to default
            assert(strokeWidth == nil, "These is a miss placed argument `strokeWidth`, please check your initializer.")
            closure.append("stroke_color", defaultColor)
            closure.append("stroke_opacity", 1)
            closure.append("stroke_width", strokeWidth ?? 4)
            closure.append("fill_color", Python.None)
            closure.append("fill_opacity", 0)
        }
        
        builder(&closure.arguments)
        
        self._pythonObject = manim[dynamicMember: closure.name].dynamicallyCall(withKeywordArguments: closure.arguments)
    }
    
    
    @_disfavoredOverload
    public required init(_pythonObject pythonObject: PythonObject) {
        self._pythonObject = pythonObject
    }
    
}


extension VMObject {
    
    /// Create and return an identical deep copy of the object including all children.
    public func copied() -> Self {
        Self(_pythonObject: self._pythonObject.copy())
    }
    
    /// The fill color of the object.
    public var fillColor: Color {
        get {
            let color = Color(self._pythonObject.fill_color)!
            let opacity = Double(self._pythonObject.fill_opacity) ?? 1
            return color.opacity(opacity)
        }
        set {
            self.fill(newValue)
        }
    }
    
    /// The stroke color of the object.
    public var strokeColor: Color {
        get {
            let color = Color(self._pythonObject.stroke_color)!
            let opacity = Double(self._pythonObject.stroke_opacity) ?? 1
            return color.opacity(opacity)
        }
        set {
            self.stroke(newValue)
        }
    }
    
    /// The stroke width.
    public var strokeWidth: Double {
        get { Double(self._pythonObject.stroke_width)! }
        set { self._pythonObject.stroke_width = newValue.pythonObject }
    }
    
    /// Collection of available cap styles.
    ///
    /// See the example below for a visual illustration of the different cap styles.
    ///
    /// ![Preview](capStyle)
    ///
    /// ```swift
    /// let arcs = CapStyle.allCases.map { style in
    ///     let arc = Arc(radius: 1, startAngle: .degrees(0), angle: .degrees(90), color: .green)
    ///     arc.strokeWidth = 20
    ///     arc.capStyle = style
    ///     return arc
    /// }
    /// scene.arrange(arcs, direction: .right, spacing: 1)
    /// scene.add(arcs)
    ///
    /// for arc in arcs {
    ///     let label = Text(arc.capStyle.description, fontSize: 24)
    ///     label.move(below: arc)
    ///     scene.add(label)
    /// }
    /// ```
    public var capStyle: CapStyle {
        get { CapStyle(self._pythonObject.cap_style)! }
        set { self._pythonObject.cap_style = newValue.pythonObject }
    }
    
    
    /// Set the fill color and fill opacity.
    ///
    /// ```swift
    /// let rect = Square(length: 2)
    ///
    /// withAnimation(in: .parallel) {
    ///     rect.fill(.red)
    ///     rect.stroke(.green)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/stroke_fill.mov)
    @discardableResult
    public func fill(_ color: Color) -> AttachedAnimation {
        AttachedAnimation(base: self, closure: Closure("set_fill", [("color", color), ("opacity", color.alpha)]))
    }
    
    /// Set the stroke color and stroke opacity.
    ///
    /// ```swift
    /// let rect = Square(length: 2)
    ///
    /// withAnimation(in: .parallel) {
    ///     rect.fill(.red)
    ///     rect.stroke(.green)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/stroke_fill.mov)
    ///
    /// - Parameters:
    ///   - color: stroke color.
    ///   - width: stroke color width.
    @discardableResult
    public func stroke(_ color: Color, width: Double? = nil) -> AttachedAnimation {
        AttachedAnimation(base: self, closure: Closure("set_stroke", [("color", color), ("opacity", color.alpha), ("width", width)]))
    }
    
    /// Applies a color gradient from a direction.
    ///
    /// ```swift
    /// let circle = Circle()
    /// circle.fill(.red)
    /// circle.stroke(.clear)
    /// circle.sheen(factor: -0.3, direction: .bottomRight)
    /// scene.add(circle)
    /// ```
    /// ![Preview](sheen)
    ///
    /// - Parameters:
    ///   - factor: The extent of lustre/gradient to apply. If negative, the gradient starts from black, if positive the gradient starts from white and changes to the current color.
    ///   - direction: Direction from where the gradient is applied.
    @discardableResult
    public func sheen(factor: Double, direction: Direction) -> AttachedAnimation {
        AttachedAnimation(base: self, closure: Closure("set_sheen", [("", factor)]))
    }
    
    /// Sets opacity.
    ///
    /// You can also use ``MObject/set(color:)`` to set color.
    ///
    /// ```swift
    /// let rect = Square(length: 2)
    ///
    /// withAnimation {
    ///     rect.set(opacity: 0.5)
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/set_opacity.mov)
    @discardableResult
    public func set(opacity: Double) -> Animation {
        AttachedAnimation(base: self, closure: Closure("set_opacity", [("opacity", opacity)]))
    }
    
}


extension VMObject {
    
    /// Cast `self` as `T`.
    ///
    /// - Warning: There is no way for the compiler to know if the type-cast is valid. Runtime error will occur if the casting fails.
    public func `as`<T>(_ type: T.Type) -> T where T: VMObject {
        T(_pythonObject: self._pythonObject)
    }
    
}
