//
//  Scene.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//




/// A Scene is the canvas of your animation.
open class Scene {
    
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
    open func construct() {
        Generator.main.add("\n    def construct(self):", ignoresIndentGuide: true)
    }
    
    
    required public init() {
        Generator.main.add("\nclass \(Self.self)(Scene):", ignoresIndentGuide: true)
    }
    
}
