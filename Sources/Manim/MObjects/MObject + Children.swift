//
//  MObject + Children.swift
//  Manim
//
//  Created by Vaida on 2025-09-23.
//


extension MObject {
    
    /// The contained objects
    ///
    /// ```swift
    /// let rect = HStack(Square(length: 2), Triangle())
    /// rect.children // [MObject(Square), MObject(Triangle)]
    /// ```
    public var children: [MObject] {
        self.pythonObject.submobjects.map({ MObject($0) })
    }
    
}
