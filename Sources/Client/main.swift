//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let axes = Axes(domain: Range(-3, 8), range: Range(-1, 1), width: 11, height: 2, xStyle: [], yStyle: [])
    scene.add(axes)
    
    let circle = Circle()
    circle.origin = axes.convert(.zero, from: .axis, to: .canvas)
    print(axes.convert(.zero, from: .axis, to: .canvas))
    print(axes.convert(.zero, from: .canvas, to: .axis))
    scene.add(circle)
} configuration: {
    $0.preview = false
//    $0.quality = .high
}
