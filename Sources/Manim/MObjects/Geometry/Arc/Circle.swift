//
//  Circle.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import Foundation

/// A circle
public class Circle: Arc {
    
    
    public init(radius: Double? = nil, strokeColor: Color? = nil) {
        super.init(args: [("radius", radius?.description),
                          ("color", strokeColor?.pyDescription)])
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    
    override init(base: String? = nil, args: Args) {
        super.init(base: base, args: args)
    }
    
}
