//
//  Scene.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//


/// A Scene is the canvas of your animation.
///
/// Different to the Manim implementation, this package allows only one scene.
open class Scene {
    
    var configuration: Generator.Configuration = .init()
    
    open func configure(_ configuration: inout Generator.Configuration) {
        
    }
    
    /// The constructor.
    ///
    /// You *must* call `super` at the beginning of your override.
    ///
    /// ```swift
    /// override func construct() {
    ///     super.construct()
    ///
    ///     // Animations here
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - width: The width of the canvas in local logical units.
    open func construct(width: Int? = nil) {
        Generator.main.add("\n    def construct(self):", ignoresIndentGuide: true)
        
        if let width {
            self.configuration.localWidth = width
        }
    }
    
    
    required public init() {
        Generator.main.add("\nclass \(Self.self)(Scene):", ignoresIndentGuide: true)
    }
    
    public static func main() throws {
        let generator = Generator.main
        try generator.generate(Self())
    }
    
}
