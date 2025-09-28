//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let text = MathTex(
        "\\frac{d}{dx}f(x)g(x)=","f(x)\\frac{d}{dx}g(x)","+",
        "g(x)\\frac{d}{dx}f(x)"
    )
    
    let box1 = SurroundingRectangle(text.children[1], padding: 0.1)
    let box2 = SurroundingRectangle(text.children[3], padding: 0.1)
    
    withAnimation {
        text.show(animation: .write)
        box1.show(animation: .create)
    }
    
    scene.sleep()
    
    withAnimation {
        box1.transform(to: box2, style: .replace)
    }
    
    scene.sleep()
} configuration: {
    $0.preview = false
    $0.quality = .high
}
