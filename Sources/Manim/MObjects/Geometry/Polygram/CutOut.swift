//
//  CutOut.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import PythonKit


/// A shape with smaller cutouts.
public final class Cutout: VMObject {
    
    init(_ base: VMObject, cutouts: [VMObject]) {
        super.init(manim.Cutout(base, cutouts))
    }
    
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}


extension VMObject {
    
    /// Creates a cutout using the given sub objects.
    public func cutout(_ objects: [VMObject]) -> Cutout {
        Cutout(self, cutouts: objects)
    }
    
    /// Creates a cutout using the given sub objects.
    public func cutout(_ objects: VMObject...) -> Cutout {
        self.cutout(objects)
    }
    
}
