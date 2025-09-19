//
//  Ellipse.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//




/// Am ellipse
public final class Ellipse: Circle {
    
    
    public convenience init(width: Double? = nil, height: Double? = nil) {
        self.init(arguments: [
            ("width",  width?.description),
            ("height", height?.description)
        ])
    }
    
}
