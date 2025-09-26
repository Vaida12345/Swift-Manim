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
    
    withAnimation {
        dot.shift(by: [0, 2])
    }
} configuration: {
    $0.preview = false
}

