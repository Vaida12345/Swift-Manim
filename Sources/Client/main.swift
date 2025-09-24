//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let dot = Dot(color: .blue)
    dot.show()
    
    let x = dot.track(\.x)
    
    withAnimation {
        x += 1
    }
} configuration: { configuration in
    configuration.preview = false
    configuration.disableCache = true
}
