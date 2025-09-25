//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim


try await withManim { scene in
    let dot = Dot()
    
    withAnimation {
        dot.show()
    }
} configuration: {
    $0.preview = false
}

