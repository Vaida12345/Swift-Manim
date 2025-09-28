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
    let numberLine = NumberLine(range: Range(0...4))
    scene.add(VStack(numberLine, number), dot)
    
    dot.move(to: numberLine.convert(number: $value))
    withAnimation {
        $value.become(.pi)
    }
    
    scene.sleep()
    withAnimation {
        $value.become(0)
    }
    
    scene.sleep()
} configuration: {
    $0.preview = false
    $0.quality = .high
}
