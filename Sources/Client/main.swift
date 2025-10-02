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
    
    debugPrint(text)
} configuration: {
    $0.preview = false
    $0.quality = .high
}
