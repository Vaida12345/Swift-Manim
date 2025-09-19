//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim


@main
class MovingDots: Scene {
    
    override func body(width: Int?) {
        super.body(width: width)
        
        let dot1 = Dot(color: .blue)
        let dot2 = Dot(color: .green)
        
        let group = Group(dot1, dot2)
        group.arrange(direction: .right)
        
        let line = Line(start: dot1.center, end: dot2.center)
        line.set(color: .red)
        line.addUpdater { line in
            line.become(Line(start: dot1.center, end: dot2.center))
            line.set(color: .red)
        }
        
        dot1.show()
        dot2.show()
        line.show()
        
        let x = dot1.x.tracker()
        let y = dot2.y.tracker()
        
        withAnimation {
            x += 4
            y += 4
        }
    }
}
