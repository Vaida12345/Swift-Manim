//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let vector = Vector([2, 2])
    let brace = Brace(vector)
    scene.add(vector, brace)
    scene.add(brace.label("2"))
} configuration: {
    $0.preview = false
}
