//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let dot = Dot()
    let plane = NumberPlane(margin: 2)
    
    let text = Text("(\(dot.x), \(dot.y))")
    text.addUpdater(initial: true) {
        text.become(Text("(\(dot.x.formatted(.number.precision(2))), \(dot.y.formatted(.number.precision(2))))"))
        text.move(rightOf: dot)
    }
    scene.add(plane, dot, text)
    
    withAnimation(.linear, in: .parallel) {
        dot.move(to: [1, 1])
        scene.camera.move(to: [1, 1])
    }
    
    scene.sleep()
} configuration: {
    $0.preview = false
    $0.quality = .high
}
