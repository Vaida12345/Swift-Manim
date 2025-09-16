//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim


@main
class VectorArrow: Scene {
    
    override func body(width: Int?) {
        super.body(width: width)
        
        let ratios = [0, 0.1, 0.5, 1]
        
        // Create dot groups
        let group = HStack(Dot(), Dot(), Dot(), Dot())
        let groups = HStack(spacing: 1, group, group.copied(), group.copied(), group.copied())
        
        groups.show()
        
        // Label groups
        let label = Text("lagRatio", fontSize: 36)
        label.move(nextTo: groups, position: .up, padding: 1.5)
        label.show()
        
        for (group, ratio) in zip(groups, ratios) {
            let text = Text("\(ratio)", fontSize: 36)
            text.move(nextTo: group, position: .up)
            text.show()
        }
        
        // Animate groups with different lag_ratios
        withAnimation {
            for (group, ratio) in zip(groups, ratios) {
                group.shift(by: [0, -2, 0])
                    .lagRatio(ratio)
            }
        }
        
        withAnimation {
            groups.shift(by: [0, 2, 0])
                .lagRatio(0.1)
                .duration(2)
        }
    }
}
