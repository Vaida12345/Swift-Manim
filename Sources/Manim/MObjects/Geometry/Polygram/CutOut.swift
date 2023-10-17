//
//  CutOut.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//




/// A shape with smaller cutouts.
public final class Cutout: VMObject {
    
    public required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    init(_ main: VMObject, cutouts: [VMObject]) {
        super.init(args: [
            (nil, main.identifier)
        ] + cutouts.map { (nil, $0.identifier) })
    }
    
}


extension VMObject {
    
    /// Creates a cutout using the given sub objects.
    public func cut(out: [VMObject]) -> Cutout {
        Cutout(self, cutouts: out)
    }
    
}
