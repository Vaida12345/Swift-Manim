//
//  Underline.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//

import PythonKit


/// An underline.
///
/// You don't create instances of this class directly, you use ``MObject/underline(padding:)``.
public final class Underline: Line {
    
    /// Creates an underline.
    init(base: MObject, padding: Double = 0.25) {
        super.init(manim.Underline(base.pythonObject, buff: padding))
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
}


extension MObject {
    
    /// Underline this instance.
    ///
    /// ```swift
    /// let text = Text("Important")
    /// scene.add(text, text.underline())
    /// ```
    ///
    /// ![Preview](underline)
    public func underline(padding: Double = 0.25) -> Underline {
        Underline(base: self, padding: padding)
    }
    
}
