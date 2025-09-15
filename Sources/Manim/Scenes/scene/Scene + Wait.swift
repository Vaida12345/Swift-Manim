//
//  Scene + Wait.swift
//  Manim
//
//  Created by Vaida on 2025-09-15.
//


extension Scene {
    
    /// Freeze animation for `duration`.
    public func wait(_ duration: Double = 2) {
        Generator.main.add("self.wait(\(duration))")
    }
}
