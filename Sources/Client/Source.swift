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
        
//        ratios = [0, 0.1, 0.5, 1, 2]  # demonstrated lag_ratios
//        
//        # Create dot groups
//        group = Group(*[Dot() for _ in range(4)]).arrange_submobjects()
//        groups = Group(*[group.copy() for _ in ratios]).arrange_submobjects(buff=1)
//        self.add(groups)
//        
//        # Label groups
//        self.add(Text("lag_ratio = ", font_size=36).next_to(groups, UP, buff=1.5))
//        for group, ratio in zip(groups, ratios):
//                    self.add(Text(str(ratio), font_size=36).next_to(group, UP))
//                
//                #Animate groups with different lag_ratios
//                self.play(AnimationGroup(*[
//                    group.animate(lag_ratio=ratio, run_time=1.5).shift(DOWN * 2)
//                    for group, ratio in zip(groups, ratios)
//                ]))
//                
//                # lag_ratio also works recursively on nested submobjects:
//                    self.play(groups.animate(run_time=1, lag_ratio=0.1).shift(UP * 2))
        
        let ratios = [0, 0.1, 0.5, 1]
        
        // Create dot groups
        let group = HStack(Dot(), Dot(), Dot(), Dot())
        let groups = HStack(group, group.copied(), group.copied(), group.copied(), spacing: 1)
        
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
