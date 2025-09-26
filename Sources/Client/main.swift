//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let rect = Square(length: 2)
    
    withAnimation {
        rect.set(opacity: 0.5)
    }
} configuration: {
    $0.preview = false
}

