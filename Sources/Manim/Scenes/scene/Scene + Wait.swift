//
//  Scene + Wait.swift
//  Manim
//
//  Created by Vaida on 2025-09-15.
//

import Foundation


extension Scene {
    
    /// Freeze animation for `duration`.
    @available(*, deprecated, renamed: "sleep")
    public func wait(_ duration: Double = 2) {
        Generator.main.add("self.wait(\(duration))")
    }
    
    /// Freeze animation for `duration`.
    public func sleep(for duration: Duration) {
        Generator.main.add("self.wait(\(Double(duration.components.attoseconds) / pow(10, 18) + Double(duration.components.seconds)))")
    }
}
