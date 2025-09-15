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
    
    public init(start: any PointProtocol, end: any PointProtocol) {
        super.init(args: [("start", start.pyDescription), ("end", end.pyDescription)])
        
        if let start = start as? Method<Point> {
            self.set.start(to: start)
        }
        if let end = end as? Method<Point> {
            self.set.end(to: end)
        }
    }
    
    override init(base: String? = nil, args: Args) {
        super.init(base: base, args: args)
    }
    
}
