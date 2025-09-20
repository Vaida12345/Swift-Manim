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
        
        NumberPlane().show()
        
        let rectangle = Rectangle(width: 4, height: 2)
        rectangle.origin.update(to: [2, 4])
        rectangle.show()
        
        let originText = Text("origin")
        originText.move(rightOf: rectangle.origin)
        
        Dot(at: rectangle.origin).show()
        rectangle.show()
        originText.show()
    }
}
