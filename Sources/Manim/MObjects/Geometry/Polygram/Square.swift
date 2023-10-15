//
//  Square.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import Foundation


/// A square.
public final class Square: Rectangle {
    
    /// Creates a square.
    ///
    /// - Parameters:
    ///   - length: The length for each side.
    public init(length: Double = 2, color: Color? = nil) {
        super.init(args: [("side_length", length.description),
                          ("color", color?.pyDescription)])
    }
    
    required init(identifier: String) { super.init(args: []) }
    
}
