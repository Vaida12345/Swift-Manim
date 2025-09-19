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
        
        let red = Dot(color: .red)
        let green = Dot(color: .green)
        let blue = Dot(color: .blue)
        let yellow = Dot(color: .yellow)
        
        red.show()
        green.show()
        blue.show()
        yellow.show()
        
        let _ = VStack(green, yellow)
        let _ = HStack(red, green, blue)
    }
}
