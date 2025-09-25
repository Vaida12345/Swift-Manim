//
//  VMObject.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//


/// A vectorized ``MObject``.
public class VMObject: MObject {
    
    
}


extension VMObject {
    
    public var fillColor: Color {
        get {
            let color = Color(self.pythonObject.fill_color)!
            let opacity = Double(self.pythonObject.fill_opacity) ?? 1
            return color.opacity(opacity)
        }
        set {
            self.fill(newValue)
        }
    }
    
    public var strokeColor: Color {
        get {
            let color = Color(self.pythonObject.stroke_color)!
            let opacity = Double(self.pythonObject.stroke_opacity) ?? 1
            return color.opacity(opacity)
        }
        set {
            self.stroke(newValue)
        }
    }
    
    public var strokeWidth: Double {
        get { Double(self.pythonObject.stroke_width)! }
        set { self.pythonObject.stroke_width = newValue.pythonObject }
    }
    
    /// Collection of available cap styles.
    ///
    /// See the example below for a visual illustration of the different cap styles.
    ///
    /// ![Preview](capStyle)
    ///
    /// ```swift
    ///  let arcs = CapStyle.allCases.map { style in
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
        get { CapStyle(self.pythonObject.cap_style)! }
        set { self.pythonObject.cap_style = newValue.pythonObject }
    }
    
    
    /// Set the fill color and fill opacity.
    @discardableResult
    public func fill(_ color: Color) -> AttachedAnimation {
        AttachedAnimation(base: self, closure: Closure("set_fill", [("color", color), ("opacity", color.alpha)]))
    }
    
    /// Set the stroke color and stroke opacity.
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
    @discardableResult
    public func set(opacity: Double) -> Animation {
        AttachedAnimation(base: self, closure: Closure("set_opacity", [("opacity", opacity)]))
    }
    
}
