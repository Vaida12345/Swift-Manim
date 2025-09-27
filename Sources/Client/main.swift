//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let point: Point = [2, 2]
    let dot = Dot(at: point)
    scene.add(dot)
} configuration: {
    $0.preview = false
}
