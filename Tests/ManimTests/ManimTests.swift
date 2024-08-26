import XCTest
import Manim
import LaTeX

final class ManimTests: XCTestCase {
    func testExample() throws {
        class TracedPathExample: Scene {
            
            override func construct() {
                super.construct()
                
                let arrow = Arrow(start: .center, end: .center.shift(1, to: .left), tip: .custom(base: Circle()))
                
                let line = Line(start: Point(x: -2, y: 1), end: Point(x: 0, y: -2))
                let dot = Dot(point: Point(x: -2, y: 1))
                
                withAnimationGroup {
                    dot.show(animation: .fadeIn())
                    line.show(animation: .rotate())
                }
                
                withAnimation {
                    line.set.start(to: dot.center.attached())
                    dot.move(to: .center)
                }
                
                sleep(for: .seconds(1))
            }
        }
        
        try Generator.main.generate([TracedPathExample.self]) { configuration in
            
        }
    }
}

