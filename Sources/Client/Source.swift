//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim


@main
class Pointer: Scene {
    
    override func construct(width: Int?) {
        super.construct(width: width)
        
        let line = NumberLine()
        let pointer = Vector(direction: .down)
        let label = MathTex("x")
        
        let dot = Dot(point: [1, 2])
        
//        label.move(nextTo: pointer, position: .down)
//        label.addUpdater { object in
//            object.move(nextTo: pointer, position: .down)
//        }
        
        line.show()
        pointer.show()
        label.show()
        dot.show()
        
        withAnimation {
            pointer.move(nextTo: dot.attached(), position: .up)
        }
        
        sleep(for: .seconds(1))
        
        withAnimation {
            dot.move(to: [2, 4])
        }
    }
}

//number_line = NumberLine()
//pointer = Vector(DOWN)
//label = MathTex("x").add_updater(lambda m: m.next_to(pointer, UP))
//
//tracker = ValueTracker(0)
//pointer.add_updater(
//    lambda m: m.next_to(
//        number_line.n2p(tracker.get_value()),
//        UP
//    )
//)
//self.add(number_line, pointer,label)
//tracker += 1.5
//self.wait(1)
//tracker -= 4
//self.wait(0.5)
//self.play(tracker.animate.set_value(5))
//self.wait(0.5)
//self.play(tracker.animate.set_value(3))
//self.play(tracker.animate.increment_value(-2))
//self.wait(0.5)
