//
//  Scene.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//


/// A Scene is the canvas of your animation.
///
/// Different to the Manim implementation, this package allows only one scene.
///
/// ``Scene``s serve as main entry point for your animations.
///
/// ```swift
/// @main
/// class DotScene: Scene {
///
///     override func body(width: Int?) {
///         super.body(width: width)
///
///         let dot = Dot()
///         dot.show()
///     }
/// }
/// ```
///
/// ## Topics
/// ### Body
/// - ``body(width:)``
///
/// ### Configuration
/// - ``configure(_:)``
///
/// ### Other Requirements
/// - ``init()``
/// - ``main()``
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
    
    /// The default initializer.
    ///
    /// You can override this initializer, but you must ensure all instance properties are initializer, and call this super-class initializer.
    required public init() {
        Generator.main.add("\n# The main scene. \nclass \(Self.self)(Scene):", ignoresIndentGuide: true)
    }
    
    /// The implicit entry point.
    ///
    /// You do not override this function, use `@main` instead.
    ///
    /// ```swift
    /// @main
    /// class DotScene: Scene {
    ///
    ///     override func body(width: Int?) {
    ///         super.body(width: width)
    ///
    ///         let dot = Dot()
    ///         dot.show()
    ///     }
    /// }
    /// ```
    public static func main() async throws {
        let generator = Generator.main
        try await generator.generate(Self.self)
    }
    
}
