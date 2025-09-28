//
//  FunctionGraph.swift
//
//
//  Created by Vaida on 2023/10/30.
//

import Foundation
import PythonKit


/// A ``ParametricFunction`` that spans the length of the scene by default.
///
/// ```swift
/// let graph = FunctionGraph { x in
///     x + 2
/// }
///
/// graph.show()
/// ```
///
/// ![preview](FunctionGraph)
public final class FunctionGraph: ParametricFunction {
    
    public init(color: Color = .yellow, range: Range? = nil, function: @escaping (Double) -> Double) {
        let function = PythonFunction { object in
            function(Double(object)!)
        }
        
        super.init(_pythonObject: manim.FunctionGraph(function, color: color, x_range: range))
    }
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
