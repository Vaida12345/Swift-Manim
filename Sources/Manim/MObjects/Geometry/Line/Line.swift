//
//  Line.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import OSLog


public class Line: VMObject {
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    public init(start: some PointProtocol, end: some PointProtocol) {
        super.init(args: [("start", start.representation), ("end", end.representation)])
    }
    
    override init(base: String? = nil, args: Closure.Arguments) {
        super.init(base: base, args: args)
    }
    
}
