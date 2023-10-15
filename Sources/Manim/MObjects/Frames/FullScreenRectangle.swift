//
//  FullScreenRectangle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import Foundation


public class FullScreenRectangle: VMObject {
    
    init() {
        super.init(args: [("stroke_width", 0.description)])
    }
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
}
