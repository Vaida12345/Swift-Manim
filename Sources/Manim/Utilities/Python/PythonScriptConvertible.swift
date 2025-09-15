//
//  PyValueProviding.swift
//  Manim
//
//  Created by Vaida on 2025-09-15.
//


/// Indicating that the structure can be represented in a python script.
public protocol PythonScriptConvertible {
    
    /// Returns the equivalent of `self` in Python, expressed as raw python scripts.
    var representation: String { get }
    
}


extension Bool: PythonScriptConvertible {
    
    public var representation: String {
        self ? "True" : "False"
    }
    
}
