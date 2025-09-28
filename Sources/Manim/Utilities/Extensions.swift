//
//  Extensions.swift
//  Manim
//
//  Created by Vaida on 2025-09-28.
//

import Foundation


extension Double {
    
    public var userFriendlyDescription: String {
        self.formatted(.number.precision(.fractionLength(2))) // always round to two, for animations.
    }
    
}
