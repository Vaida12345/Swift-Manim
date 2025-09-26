//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let line = Line(from: .center, to: [2, 2])
    line.addTip(at: .start)
    line.addTip(at: .end)
    
    withAnimation(in: .parallel) {
        line.show()
    }
} configuration: {
    $0.preview = false
}

