//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let hex = RegularPolygon(n: 6, fill: .blue)
    let rect = SurroundingRectangle(hex)
    rect.color = .yellow
    scene.add(hex, rect)
} configuration: {
    $0.preview = false
}
