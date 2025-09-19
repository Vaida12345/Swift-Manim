//
//  MObject + Modifiers.swift
//  Manim
//
//  Created by Vaida on 2025-09-19.
//

import SwiftUI


extension MObject {
    
    /// Adds an argument to python initializer.
    func addInitializerArgument(_ key: String, _ value: some PythonScriptConvertible) {
        self.addInitializerArgument(key, value.representation)
    }
    
    /// Adds an argument to python initializer.
    func addInitializerArgument(_ key: String, _ value: String) {
        assert(!self.identifier.isEmpty)
        
        guard let declarationIndex = Generator.main.components.firstIndex(where: { component in
            switch component {
            case let .declaration(_, name, _): return name == self.identifier
            default: return false
            }
        }) else { fatalError("Consistency Error: \(self.identifier) not defined") }
        
        var declaration = Generator.main.components[declarationIndex]
        switch declaration {
        case let .declaration(indentation, name, initializer): declaration = .declaration(indentation: indentation, name: name, initializer: Closure(initializer.name, Closure.Arguments(initializer.arguments.contents + [Closure.Argument(key, value)])))
        default: return
        }
        Generator.main.components[declarationIndex] = declaration
    }
    
    
    /// Write-only property for setting color.
    public var color: Color {
        get { fatalError("Does not support GET") }
        set { self.addInitializerArgument("color", newValue) }
    }
    
    /// Write-only property for setting zIndex.
    public var zIndex: Int {
        get { fatalError("Does not support GET") }
        set { self.addInitializerArgument("zIndex", newValue.description) }
    }
    
}
