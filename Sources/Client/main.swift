//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let ellipse = Ellipse(width: 4, height: 2, stroke: .white)
    scene.add(ellipse)
} configuration: {
    $0.preview = false
}
