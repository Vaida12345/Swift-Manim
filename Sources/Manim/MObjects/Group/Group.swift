//
//  Group.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import PythonKit


/// A group of vectorized ``MObject``.
public class Group: VMObject {
    
    public var description: String {
        "\(type(of: self as Any))(\(self.children))"
    }
    
    /// Arranges ``VMObject/children`` in `direction`.
    public func arrange(direction: Direction, spacing: Double = 0.25) {
        self._pythonObject.arrange(direction, buff: spacing)
    }
    
    public init(_ children: [MObject]) {
        let object = manim.Group.dynamicallyCall(withArguments: children.map(\._pythonObject))
        super.init(_pythonObject: object)
    }
    
    @_disfavoredOverload
    public convenience init(_ children: MObject...) {
        self.init(children)
    }
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, defaultColor: Color = .white, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, defaultColor: defaultColor, builder)
    }
    
}
