//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let dot = Dot(at: .zero)
    let circle = Circle()
    
    circle.addUpdater {
        circle.shift(by: [0.1, 0])
    }
    
    scene.add(dot, circle)
    
    scene.sleep()
} configuration: {
    $0.preview = false
    $0.quality = .high
}
