//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim


try await withManim { scene in
    let rect = Rectangle(width: 4, height: 2)
    rect.stroke(.white, width: 6)
    rect.fill(.white.opacity(0.5))
    rect.show()
} configuration: {
    $0.preview = false
}

