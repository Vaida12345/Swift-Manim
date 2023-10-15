//
//  Triangle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//

import Foundation


/// A background rectangle. Its default color is the background color of the scene.
public final class Triangle: RegularPolygon {
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    public init() {
        super.init(args: [])
    }
    
}
