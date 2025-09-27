//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    @ValueTracker var value = 0.0
    let number = DecimalNumber($value, format: .precision(fractionLength: 4))
    let dot = Dot()
    let numberLine = NumberLine(range: Range(0...5))
    scene.add(VStack(numberLine, number), dot)
    
    dot.addUpdater {
        dot.move(to: numberLine.convert(number: value))
    }
    withAnimation {
        $value.become(.pi)
    }
    
    scene.sleep()
} configuration: {
    $0.preview = false
}
