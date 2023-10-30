import XCTest
import Manim
import LaTeX

final class ManimTests: XCTestCase {
    func testExample() throws {
        class TracedPathExample: Scene {
            
            override func construct() {
                super.construct()
                
                let function = FunctionGraph { x in
                    LaTeX.sin(x)
                }
                withAnimation {
                    function.show()
                }
                
                sleep(for: .seconds(1))
            }
        }
        
        try Generator.main.generate([TracedPathExample.self]) { configuration in
            
        }
    }
}
