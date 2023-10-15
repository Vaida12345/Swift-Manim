//
//  Ellipse.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import Foundation


/// Am ellipse
public final class Ellipse: Circle {
    
    
    public init(width: Double? = nil, height: Double? = nil) {
        super.init(args: [
            ("width",  width?.description),
            ("height", height?.description)
        ])
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    
}
