//
//  Transform.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import PythonKit


/// A Transform transforms a ``MObject`` into a target ``MObject``.
///
/// You can use the ``MObject/transform(to:transform:)`` to create a transform.
@MainActor
public enum Transform {
    
    /// Performs the transform in an arc instead of straight line.
    case clockwise
    
    /// Performs the transform in an arc instead of straight line.
    case counterClockwise
    
    /// An animation trying to transform groups by matching the shape of their sub-objects.
    ///
    /// This method is similar to Magic Move, match characters.
    case matchShapes
    
    /// A transformation trying to transform rendered LaTeX strings.
    ///
    /// Two sub-objects match if their components matches.
    case matchTex
    
    
    public var pythonObject: PythonObject {
        switch self {
        case .clockwise: manim.ClockwiseTransform
        case .counterClockwise: manim.CounterclockwiseTransform
        case .matchShapes: manim.TransformMatchingShapes
        case .matchTex: manim.TransformMatchingTex
        }
    }
    
}


extension MObject {
    
    /// Creates a transformation.
    ///
    /// - Parameters:
    ///   - target: The destination.
    ///   - transform: The transform used.
    public func transform(to target: MObject, transform: Transform = .matchShapes) -> WrappedAnimation {
        WrappedAnimation(base: self.pythonObject, caller: transform.pythonObject, arguments: [("", target)])
    }
    
}
