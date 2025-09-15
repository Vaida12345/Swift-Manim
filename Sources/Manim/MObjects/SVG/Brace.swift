//
//  Brace.swift
//  Manim
//
//  Created by Vaida on 8/27/24.
//


public class Brace: MObject {
    
    public init(_ object: MObject, direction: Direction = .down) {
        super.init(args: [
            (nil, object.identifier),
            ("direction", direction.representation)
        ])
    }
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
}
