//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let styles: [Arrow.TipShape] = [.circle, .diamond, .triangle]
    let arrows = styles.flatMap { style in
        [(Arrow(from: [-2, 0], to: [1, 0], tip: style), style), (Arrow(from: [-2, 0], to: [1, 0], tip: style.filled), style.filled)]
    }
    scene.add(VStack(arrows.map(\.0)))
    for (arrow, style) in arrows {
        let text = Text(style.description)
        text.scale(0.5)
        text.move(rightOf: arrow)
        scene.add(text)
    }
} configuration: {
    $0.preview = false
}
