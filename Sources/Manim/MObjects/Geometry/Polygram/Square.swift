//
//  Square.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//




/// A square.
public final class Square: Rectangle {
    
    /// Creates a square.
    ///
    /// - Parameters:
    ///   - length: The length for each side.
    ///   - color: The fill color.
    public convenience init(length: Double = 2, color: Color? = nil) {
        self.init(arguments: [("side_length", length.description),
                          ("color", color?.representation)])
    }
    
}
