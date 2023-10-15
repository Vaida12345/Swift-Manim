import XCTest
@testable import Manim

final class swiftManimTests: XCTestCase {
    func testExample() throws {
        class TracedPathExample: Scene {
            
            override func construct() {
                super.construct()
                
                let text = Text("Hello~")
                
                withAnimation {
                    text.show()
                }
                
                withAnimation {
                    text.offset(x: -1)
                }
                
                sleep(for: .seconds(1))
            }
        }
        
        try Generator.main.generate([TracedPathExample.self]) { configuration in
            
        }
    }
}
