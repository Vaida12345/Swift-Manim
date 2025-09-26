//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let dot1 = Dot(at: [0, 2], color: .blue)
    let dot2 = Dot(at: .center, color: .green)
    
    scene.add(dot1, dot2)
    
    dot1.bind(\.x, to: dot2.x)
    
    withAnimation {
        dot2.move(to: [2, 0])
    }
} configuration: {
    $0.preview = false
}

