//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let dest = MathTex("3", "^2", "+", "4", "^2", "=", "5", "^2")
    dest.move(to: [0, -1])
    
    withAnimation {
        MathTex("a", "^2", "+", "b", "^2", "=", "c", "^2")
            .transform(to: dest, style: .matchTex)
    }
     
    scene.sleep()
} configuration: {
    $0.preview = false
}
