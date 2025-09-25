//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim


try await withManim { scene in
    let circle = Circle()
    circle.fill(.red)
    circle.stroke(.clear)
    circle.sheen(factor: -0.3, direction: .bottomRight)
    scene.add(circle)
} configuration: {
    $0.quality = .medium
    $0.preview = false
}
