//
//  ParametricFunction.swift
//  Manim
//
//  Created by Vaida on 2025-09-24.
//


/// A parametric curve.
///
/// To create an instance, use either ``FunctionGraph`` or ``Axes/plot(color:range:function:)``. To unlock a full range of capabilities, such as ``Axes/convert(_:from:to:)``, use ``Axes/plot(color:range:function:)``.
///
/// In Swift, you can evaluate a function using ``callAsFunction(_:)``.
public class ParametricFunction: VMObject {
    
    /// Evaluate a function.
    public func callAsFunction(_ x: Double) -> Double {
        Double(self._pythonObject.get_function()(x)[1])!
    }
    
    /// The integral of `self`.
    public var integral: ParametricFunction {
        let axes = Axes()
        return ParametricFunction(_pythonObject: axes._pythonObject.plot_antiderivative_graph(self._pythonObject))
    }
    
    /// The derivative of `self`.
    public var derivative: ParametricFunction {
        let axes = Axes()
        return ParametricFunction(_pythonObject: axes._pythonObject.plot_derivative_graph(self._pythonObject))
    }
    
}
