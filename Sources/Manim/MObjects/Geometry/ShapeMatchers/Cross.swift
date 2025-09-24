//
//  Cross.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//

import PythonKit

/// Creates a cross mark.
public final class Cross: Group {
    
    /// Creates a cross.
    ///
    /// - Parameters:
    ///   - base: The object linked to this instance. It fits the mobject when specified.
    public init(base: MObject? = nil, strokeStyle: StrokeStyle) {
        super.init(manim.Cross(mobject: base, stroke_color: strokeStyle.color, stroke_width: strokeStyle.lineWidth))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    
    @MainActor
    public struct StrokeStyle {
        
        let color: Color
        
        let lineWidth: Double
        
        
        public init(color: Color = .red, lineWidth: Double = 6) {
            self.color = color
            self.lineWidth = lineWidth
        }
        
    }
    
}
