//
//  Line.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import Foundation


public class Line: VMObject {
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    public init(start: any PointLike, end: any PointLike) {
        super.init(args: [("start", start.pyDescription), ("end", end.pyDescription)])
    }
    
    override init(base: String? = nil, args: Args) {
        super.init(base: base, args: args)
    }
    
}
