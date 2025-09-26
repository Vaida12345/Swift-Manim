//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let vector = Vector([1, 1])
    scene.add(vector)
} configuration: {
    $0.preview = false
}
