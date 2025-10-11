//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let arrow = Arrow(from: .zero, to: [1, 0])
    scene.add(arrow)
    
    let trace = arrow.trace(\.end, dissipatingTime: 2)
    scene.add(trace)
    
    withAnimation {
        arrow.rotate(angle: .degrees(360), about: .zero)
    }
    
    scene.sleep()
} configuration: {
    $0.preview = false
    $0.quality = .high
}
