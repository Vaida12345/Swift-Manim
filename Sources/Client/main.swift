//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim


try await withManim { scene in
    let arc = Arc(radius: 1, startAngle: .degrees(0), angle: .degrees(90), color: .green)
    arc.addTip(at: .start)
    withAnimation(in: .serial) {
        arc.show()
    }
    
    scene.sleep(for: .seconds(1))
} configuration: {
    $0.quality = .medium
    $0.preview = false
}
