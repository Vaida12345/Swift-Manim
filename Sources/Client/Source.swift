//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import CoreGraphics


@main
class SampleScene: Scene {
    
    override func construct(width: Int?) {
        super.construct(width: 20)
        
        let dot = Dot(point: Point(x: 10, y: 10))
        dot.add(dot)
        
        sleep(for: .seconds(1))
    }
}
