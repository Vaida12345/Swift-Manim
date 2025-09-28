//
//  Brace.swift
//  Manim
//
//  Created by Vaida on 8/27/24.
//

import PythonKit


/// Takes a ``MObject`` and draws a brace adjacent to it.
///
/// ```swift
/// let line = Line(from: [-2, -1], to: [2, 1], color: .orange)
///
/// let brace = Brace(line, direction: .angle(line.angle + .degrees(90)))
/// let text = brace.label(math: "x-x_1")
///
/// scene.add(line, brace, text)
/// ```
///
/// ![Preview](Brace)
public final class Brace: VMObject {
    
    /// Creates a brace
    ///
    /// - Parameters:
    ///   - object: The object that is braced.
    ///   - direction: Passing a direction vector determines the direction from which the brace is drawn.
    ///   - color: The color of the brace.
    public init(_ object: MObject, direction: Direction = .bottom, color: Color = .white) {
        super.init(manim.Brace(object.pythonObject, direction: direction, color: color))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}


extension Brace {
    
    /// Places the text compiled in normal mode at the brace tip.
    ///
    /// ```swift
    /// let vector = Vector([2, 2])
    /// let brace = Brace(vector)
    /// scene.add(vector, brace)
    /// scene.add(brace.label("2"))
    /// ```
    ///
    /// ![Preview](Brace_label)
    public func label(_ string: String) -> Tex {
        Tex(self.pythonObject.get_text(string))
    }
    
    /// Places the text compiled in LaTeX mode at the brace tip.
    ///
    /// ```swift
    /// let vector = Vector([2, 2])
    /// let brace = Brace(vector)
    /// scene.add(vector, brace)
    /// scene.add(brace.label("2"))
    /// ```
    ///
    /// ![Preview](Brace_label)
    public func label(math string: String) -> MathTex {
        MathTex(self.pythonObject.get_tex(string))
    }
    
}
