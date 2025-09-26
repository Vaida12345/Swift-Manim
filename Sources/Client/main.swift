//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let text = Text("Circumscribe")
    scene.add(text)
    
    withAnimation {
        text.circumscribe()
    }
} configuration: {
    $0.preview = false
}

