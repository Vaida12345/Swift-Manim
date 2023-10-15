//
//  Scene.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import Foundation


/// A Scene is the canvas of your animation.
open class Scene {
    
    public func configure(_ configuration: inout Generator.Configuration) {
        
    }
    
    open func construct() {
        Generator.main.add("\n    def construct(self):", ignoresIndentGuide: true)
    }
    
    
    required public init() {
        Generator.main.add("\nclass \(Self.self)(Scene):", ignoresIndentGuide: true)
    }
    
}
