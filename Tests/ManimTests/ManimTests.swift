import XCTest
import Manim

final class ManimTests: XCTestCase {
    func testExample() throws {
        class TracedPathExample: Scene {
            
            override func construct() {
                super.construct()
                
                let axis = Axes()
                withAnimation {
                    axis.show()
                }
            }
        }
        
        try Generator.main.generate([TracedPathExample.self]) { configuration in
            
        }
    }
}
