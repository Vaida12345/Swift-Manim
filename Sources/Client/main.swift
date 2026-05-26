//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
    let rect = Rectangle(width: 1, height: 1)
    rect.scale(0.5)
    let lhs = VStack(rect, rect.copied(), rect.copied(), rect.copied())
    let rhs = lhs.copied()
    
    let _lhs = Matrix([[1, 2], [3, 4]])
    let _multiplication = MathTex(#"\times"#)
    let _rhs = Matrix([[5, 6], [7, 8]])
    
    let _stack = HStack(_lhs, _multiplication, _rhs)
    
    lhs.move(to: _lhs)
    rhs.move(to: _rhs)
    
    let title = Text("Matrix Multiplication", fontSize: 60)
    title.move(above: _stack, padding: 1.25)
    
    withAnimation(in: .parallel) {
        title.show(animation: .write)
    }
    
    scene.sleep()
    
    withAnimation(in: .parallel) {
        lhs.show()
            .lagRatio(0.8)
        
        rhs.show()
            .lagRatio(0.8)
            .delay(0.2)
    }
    
    let group = Group([])
    for lhs in lhs.children {
        for rhs in rhs.children {
            let line = Arrow(from: lhs.right, to: rhs.left, width: 2, padding: 0.05)
            line.color = .gray
            group.add(line)
        }
    }
    
    withAnimation {
        group.show()
            .lagRatio(0.8)
            .duration(2)
    }
    
    scene.sleep()
    
    withAnimation(in: .parallel) {
        lhs.become(_lhs)
        rhs.become(_rhs)
        group.become(_multiplication)
    }
} configuration: {
    $0.preview = false
    $0.quality = .high
}
