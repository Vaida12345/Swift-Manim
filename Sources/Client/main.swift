//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let text = Text("Important")
    scene.add(text, text.underline())
} configuration: {
    $0.preview = false
}

