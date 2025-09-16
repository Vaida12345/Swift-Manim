//
//  Scene.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//


/// A Scene is the canvas of your animation.
///
/// Different to the Manim implementation, this package allows only one scene.
@MainActor
open class Scene {
    
    /// Default stores config.
    var config: Generator.Configuration = .init()
    
    /// Changes the configuration for the scene.
    open func configure(_ configuration: inout Generator.Configuration) {
        
    }
    
    /// The body.
    ///
    /// You *must* call `super` at the beginning of your override.
    ///
    /// ```swift
    /// override func body() {
    ///     super.body()
    ///
    ///     // Animations here
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - width: The width of the canvas in local logical units.
    open func body(width: Int? = nil) {
        Generator.main.add("\n    def construct(self):", ignoresIndentGuide: true)
        
        if let width {
            self.config.localWidth = width
        }
    }
    
    
    required public init() {
        Generator.main.add("\n# The main scene. \nclass \(Self.self)(Scene):", ignoresIndentGuide: true)
    }
    
    public static func main() async throws {
        let generator = Generator.main
        try await generator.generate(Self.self)
    }
    
}
