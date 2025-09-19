//
//  CutOut.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//




/// A shape with smaller cutouts.
public final class Cutout: VMObject {
    
    convenience init(_ main: VMObject, cutouts: [VMObject]) {
        self.init(arguments: Closure.Arguments([
            Closure.Argument(nil, main.identifier)
        ] + cutouts.map { Closure.Argument(nil, $0.identifier) }))
    }
    
}


extension VMObject {
    
    /// Creates a cutout using the given sub objects.
    public func cut(out: [VMObject]) -> Cutout {
        Cutout(self, cutouts: out)
    }
    
}
