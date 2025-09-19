//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim

@main
class VectorArrow: Scene {
    
    override func body(width: Int?) {
        super.body(width: width)
        
        let first = Dot()
        first.color = .blue
        
        let second = Dot()
        second.move(nextTo: first, placing: .right)
        second.color = first.color
        
        first.show()
        second.show()
    }
}
