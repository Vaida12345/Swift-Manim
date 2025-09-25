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
    
    public var color: Color {
        get { Color(self.pythonObject.color)! }
        set { self.pythonObject.color = newValue.pythonObject }
    }
    
    public var fillColor: Color {
        get {
            let color = Color(self.pythonObject.fill_color)!
            let opacity = Double(self.pythonObject.fill_opacity) ?? 1
            return color.opacity(opacity)
        }
        set {
            self.pythonObject.fill_color = newValue.pythonObject
            self.pythonObject.fill_opacity = newValue.alpha.pythonObject
        }
    }
    
    public var strokeColor: Color {
        get {
            let color = Color(self.pythonObject.stroke_color)!
            let opacity = Double(self.pythonObject.stroke_opacity) ?? 1
            return color.opacity(opacity)
        }
        set {
            self.pythonObject.stroke_color = newValue.pythonObject
            self.pythonObject.stroke_opacity = newValue.alpha.pythonObject
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
    public func stroke(_ color: Color, width: Double = 2) -> AttachedAnimation {
        AttachedAnimation(base: self, closure: Closure("set_stroke", [("color", color), ("opacity", color.alpha), ("width", width)]))
    }
    
}
