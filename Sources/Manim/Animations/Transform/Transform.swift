//
//  Transform.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//


/// A Transform transforms a ``MObject`` into a target ``MObject``.
///
/// You can use the ``MObject/transform(to:option:)`` to create a transform.
public class Transform: Animation {
    
    init(from object: MObject, to target: MObject, option: Option?) {
        switch option {
        case nil:
            super.init(args: [(nil, object.identifier),
                              (nil, target.identifier)])
        case .clockwise:
            super.init(base: "ClockwiseTransform", args: [(nil, object.identifier), (nil, target.identifier)])
        case .counterClockwise:
            super.init(base: "CounterclockwiseTransform", args: [(nil, object.identifier), (nil, target.identifier)])
            
        case .matchShapes:
            super.init(base: "TransformMatchingShapes", args: [(nil, object.identifier), (nil, target.identifier)])
            
        case .matchTex:
            super.init(base: "TransformMatchingTex", args: [(nil, object.identifier), (nil, target.identifier)])
        }
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    
    
    /// Transform option, specifies how to transform.
    public enum Option {
        
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
    }
    
}


extension MObject {
    
    /// Creates a transformation.
    ///
    /// - Parameters:
    ///   - target: The destination.
    ///   - option: Additional setups.
    public func transform(to target: MObject, option: Transform.Option? = nil) -> Animation { Transform(from: self, to: target, option: option) }
    
}
