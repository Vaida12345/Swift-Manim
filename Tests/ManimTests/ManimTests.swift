import XCTest
import Manim

final class ManimTests: XCTestCase {
    func testExample() throws {
        class TracedPathExample: Scene {
            
            override func construct() {
                super.construct()
                
                let axis = Axes(style: .both(.init(include: [.numbers, .ticks], scaling: .log())))
                withAnimation {
                    axis.show()
                }
                
                sleep(for: .seconds(1))
            }
        }
        
        try Generator.main.generate([TracedPathExample.self]) { configuration in
            
        }
    }
}
