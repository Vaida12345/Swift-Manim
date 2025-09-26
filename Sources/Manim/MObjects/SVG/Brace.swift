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
/// let vector = Vector([2, 2])
/// let brace = Brace(vector)
/// scene.add(vector, brace)
/// ```
///
/// ![Preview](Brace)
public final class Brace: VMObject {
    
    /// Creates a brace
    ///
    /// - Parameters:
    ///   - object: The object that is braced.
    ///   - direction: Passing a direction vector determines the direction from which the brace is drawn.
    public init(_ object: MObject, direction: Direction = .bottom) {
        super.init(manim.Brace(object.pythonObject, direction: direction))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}


extension Brace {
    
    /// Places the text at the brace tip.
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
    
}
