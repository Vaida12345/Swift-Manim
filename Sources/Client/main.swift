//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim


try await withManim { scene in
    
    let dot = Dot(at: [2, 0])
    let trace = dot.trace(\.center, dissipatingTime: 0.5)
    scene.add(dot, trace)
    
    withAnimation(in: .serial) {
        dot.shift(by: [-2, 0])
            .path(.arc(.degrees(45)))
        dot.shift(by: [-2, 0])
            .path(.arc(.degrees(-45)))
    }
    
    scene.sleep()
} configuration: {
    $0.quality = .medium
    $0.preview = false
}
