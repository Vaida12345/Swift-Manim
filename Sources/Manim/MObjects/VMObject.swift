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
        get { Color(self.pythonObject.fill_color)! }
        set { self.pythonObject.fill_color = newValue.pythonObject }
    }
    
    public var strokeColor: Color {
        get { Color(self.pythonObject.stroke_color)! }
        set { self.pythonObject.stroke_color = newValue.pythonObject }
    }
    
    
    /// Set the fill color and fill opacity.
    ///
    /// - Parameters:
    ///   - color: Fill color.
    ///   - opacity: Fill opacity.
    @discardableResult
    public func fill(_ color: Color, opacity: Double = 1) -> AttachedAnimation {
        AttachedAnimation(base: self, closure: Closure("set_fill", [("color", color), ("opacity", opacity)]))
    }
    
    /// Set the stroke color and stroke opacity.
    ///
    /// - Parameters:
    ///   - color: stroke color.
    ///   - width: stroke color width.
    ///   - opacity: stroke opacity.
    @discardableResult
    public func stroke(_ color: Color, width: Double = 2, opacity: Double = 1) -> AttachedAnimation {
        AttachedAnimation(base: self, closure: Closure("set_stroke", [("color", color), ("opacity", opacity), ("width", width)]))
    }
    
}
