//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let line = Line(from: [-2, -1], to: [2, 1], color: .orange)
    
    let brace = Brace(line, direction: .angle(line.angle.rotated(by: .degrees(90))))
    let text = brace.label(math: "x-x_1")
    
    scene.add(line, brace, text)
} configuration: {
    $0.preview = false
    $0.quality = .high
}
