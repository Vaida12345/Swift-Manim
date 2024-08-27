//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim


@main
class Pointer: Scene {
    
    override func configure(_ configuration: inout Generator.Configuration) {
        configuration.format = .mp4
    }
    
    override func construct(width: Int?) {
        super.construct(width: width)
        
//        let plane = NumberPlane()
//        plane.show()
        
        let dot1 = Dot([0, 0])
        
        let deltaX = ValueTracker(value: 3)
        let deltaY = ValueTracker(value: 3)
        
        let _line = Line(start: Point(x: -10, y: -10), end: Point(x: 10, y: 10))
        _line.show()
        
        let dot2 = Dot([3, 3])
        dot2.x = deltaX
        dot2.y = deltaY
        
        let dot3 = Dot([3, 0])
        dot3.x = deltaX
        
        let line = Arrow(start: dot1.center.attached(), end: dot2.center.attached())
        line.set(color: .blue)
        
        let raise = Arrow(start: dot3.center.attached(), end: dot2.center.attached())
        raise.set(color: .red)
        
        let run = Arrow(start: dot1.center.attached(), end: dot3.center.attached())
        run.set(color: .green)
        
        let raiseText = Text("Raise")
        raiseText.set(color: .red)
        
        let runText = Text("Run")
        runText.set(color: .green)
        
        sleep(for: .seconds(2))
        
        withAnimation {
            dot1.show()
            dot2.show()
        }
        
        sleep(for: .seconds(2))
        
        withAnimation {
            line.show()
            dot3.show()
            raise.show()
            run.show()
        }
        
        withAnimationGroup {
            raiseText.show()
            runText.show()
            raiseText.move(nextTo: raise.attached(), position: .right)
            runText.move(nextTo: run.attached(), position: .down)
        }
        
//        sleep(for: .seconds(2))
//        
//        let text = MathTex("m=\\frac{raise}{run}\\\\=\\frac{\(deltaY.value)}{\(deltaX.value)}=\(deltaY.value)/\(deltaX.value)")
//        text.move(to: [-2, 2])
//        text.addUpdater {
//            $0.become(MathTex("m=\\frac{raise}{run}\\\\=\\frac{\(deltaY.value)}{\(deltaX.value)}=\(deltaY.value)/\(deltaX.value)"))
//            $0.move(to: [-2, 2])
//        }
        
//        withAnimation {
//            text.show()
//        }
        
        sleep(for: .seconds(1))
        
//        withAnimationGroup {
//            deltaX += 1
//            deltaY += 1
//        }
//        
//        withAnimationGroup(duration: 3) {
//            deltaX -= 8
//            deltaY -= 8
//        }
        
        withAnimation {
            NumberPlane().show()
        }
        
        sleep(for: .seconds(3))
        
        withAnimationGroup(duration: 5) {
            _line.become(Line(start: Point(x: -10, y: 10), end: Point(x: 10, y: -10)))
            deltaY -= 6
        }
        
        sleep(for: .seconds(3))
        
        withAnimationGroup(duration: 10) {
            _line.become(Line(start: Point(x: -10, y: 0), end: Point(x: 10, y: 0)))
            deltaX.set(10)
            deltaY.set(0.01)
        }
        
        sleep(for: .seconds(2))
        
        withAnimationGroup(duration: 10) {
            _line.become(Line(start: Point(x: 0, y: -10), end: Point(x: 0, y: 10)))
            deltaY.set(10)
            deltaX.set(0.01)
        }
        
        sleep(for: .seconds(3))
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
