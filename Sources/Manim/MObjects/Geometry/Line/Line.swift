//
//  Line.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import OSLog


public class Line: VMObject {
    
    public init(from start: some PointProtocol, to end: some PointProtocol) {
        super.init(arguments: [("start", start.representation), ("end", end.representation)])
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) { super.init(typeIdentifier, arguments: arguments) }
    
}
