//
//  Circle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//



/// A circle
public class Circle: Arc {
    
    
    public convenience init(radius: Double? = nil, strokeColor: Color? = nil) {
        self.init(arguments: [("radius", radius?.description),
                              ("color", strokeColor?.representation)])
    }
    
}
