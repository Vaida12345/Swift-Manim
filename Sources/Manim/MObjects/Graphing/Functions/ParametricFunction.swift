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
        Double(self.pythonObject.get_function()(x)[1])!
    }
    
    /// The integral of `self`.
    public var integral: ParametricFunction {
        ParametricFunction(self.pythonObject.plot_antiderivative_graph(self.pythonObject))
    }
    
    /// The derivative of `self`.
    public var derivative: ParametricFunction {
        ParametricFunction(self.pythonObject.plot_derivative_graph(self.pythonObject))
    }
    
}
