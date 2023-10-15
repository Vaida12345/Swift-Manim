//
//  Vector.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//


/// A vector, with the `start` being `.zero`.
public final class Vector: Arrow {
    
    
    public required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    public init(_ vector: PointLike) {
        super.init(args: [("direction", vector.pyDescription)])
    }
    
    
    /// The coordinates label of this object.
    public func coordinatesLabel() -> MObject {
        MObject(identifier: "\(self.identifier).coordinate_label()")
    }
    
}
