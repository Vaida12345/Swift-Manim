//
//  MObject + Children.swift
//  Manim
//
//  Created by Vaida on 2025-09-23.
//


extension VMObject {
    
    /// The contained objects
    ///
    /// ```swift
    /// let rect = HStack(Square(length: 2), Triangle())
    /// rect.children // [MObject(Square), MObject(Triangle)]
    /// ```
    public var children: [VMObject] {
        self._pythonObject.submobjects.map({ VMObject(_pythonObject: $0) })
    }
    
}
