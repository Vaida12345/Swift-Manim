//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let axes = Axes()
    let function = axes.plot(function: sin)
    let line = axes.makeLines(to: Point(x: 2, y: function(2)))
    scene.add(axes, function, line)
} configuration: {
    $0.preview = false
}
