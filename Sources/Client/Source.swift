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
        
        let dot1 = Dot(at: [2, 2], color: .blue)
        let dot2 = Dot(at: .center, color: .green)
        
        dot1.show()
        dot2.show()
        
        withAnimation {
            dot1.x.bind(to: dot2.x)
        }
        
        let tracker = dot2.x.tracker()
        
        withAnimation {
            tracker += 5
        }
        
//        let line = Line(start: dot1.center.attached(), end: dot2.center.attached())
////        line.set(color: .red)
//        
//        withAnimation(in: .parallel) {
//            dot1.show()
//                .duration(3)
//            dot2.show()
//            line.show()
//        }
//        
//        dot1.x = dot2.x.attached()
//        
//        withAnimation {
//            dot1.x += 4
//        }
//        
//        withAnimation {
//            dot1.x += 4
//        }
    }
}
