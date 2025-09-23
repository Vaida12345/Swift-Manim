//
//  Number.swift
//  Manim
//
//  Created by Vaida on 2025-09-23.
//


public protocol Number: PythonScriptConvertible {
    
}

extension Double: Number { public var representation: String { self.description } }
