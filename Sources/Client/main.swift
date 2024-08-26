//
//  main.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import CoreGraphics


class SampleScene: Scene {
    
    override func configure(_ configuration: inout Generator.Configuration) {
        configuration.localSize = CGSize(width: 10 * 5, height: 10 * 5)
    }
    
    override func construct() {
        super.construct()
        
        Axes(domain: .init(min: -10, max: 10), range: .init(min: -10, max: 10), length: (20, 20)).show()
        
        Dot(point: Point(x: 10, y: 10)).show()
        
        
        sleep(for: .seconds(1))
    }
}

try Generator.main.generate([SampleScene.self])
