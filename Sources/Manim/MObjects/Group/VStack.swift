//
//  VStack.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//

import PythonKit


/// A vertical stack
public final class VStack: Group {
    
    public init(spacing: Double = 0.25, _ children: [MObject]) {
        super.init(children)
        super.arrange(direction: .bottom, spacing: spacing)
    }
    
    public convenience init(spacing: Double = 0.25, _ children: MObject...) {
        self.init(spacing: spacing, children)
    }
    
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
