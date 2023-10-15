import XCTest
import Manim

final class ManimTests: XCTestCase {
    func testExample() throws {
        class TracedPathExample: Scene {
            
            override func construct() {
                super.construct()
                
                let arrow = Arrow(start: .center, end: .center.shift(1, to: .left), tip: .custom(base: Circle()))
                
                withAnimation {
                    arrow.show()
                }
            }
        }
        
        try Generator.main.generate([TracedPathExample.self]) { configuration in
            
        }
    }
}
