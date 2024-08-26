//
//  MathTex.swift
//  Manim
//
//  Created by Vaida on 8/26/24.
//


public class MathTex: SVGMObject {
    
    public init(_ latex: String) {
        super.init(args: [(nil, "r\"\(latex)\"")])
    }
    
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
}
