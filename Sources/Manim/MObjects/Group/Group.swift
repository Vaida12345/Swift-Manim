//
//  Group.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import PythonKit


/// A group of vectorized ``MObject``.
public class Group: VMObject {
    
    public override var description: String {
        "\(type(of: self as Any))(\(self.children))"
    }
    
    public func arrange(direction: Direction, spacing: Double = 0.25) {
        self.pythonObject.arrange(direction, buff: spacing)
    }
    
    public init(_ children: [MObject]) {
        let object = manim.Group.dynamicallyCall(withArguments: children.map(\.pythonObject))
        super.init(object)
    }
    
    @_disfavoredOverload
    public convenience init(_ children: MObject...) {
        self.init(children)
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
