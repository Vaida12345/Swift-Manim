//
//  Vector.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//


/// A vector, with the `start` being `.zero`.
public final class Vector: Arrow {
    
    public convenience init(direction: Direction) {
        self.init(arguments: [("direction", direction.representation)])
    }
    
    
    /// The coordinates label of this object.
    public func coordinatesLabel() -> MObject {
        MObject(identifier: "\(self.identifier).coordinate_label()")
    }
    
}
