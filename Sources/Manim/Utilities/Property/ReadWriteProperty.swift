//
//  ReadWriteProperty.swift
//  Manim
//
//  Created by Vaida on 2025-09-15.
//


/// Properties that can both read from and write to.
public final class ReadWriteProperty<Value>: ReadableProperty<Value> {
    
    /// The closure for writing a property.
    let write: Closure
    
    init(origin: MObject, read: Closure, write: Closure) {
        self.write = write
        super.init(origin: origin, read: read)
    }
    
    
    public static func == (_ lhs: ReadWriteProperty, _ rhs: ReadWriteProperty) -> Bool {
        lhs.origin === rhs.origin &&
        lhs.read == rhs.read &&
        lhs.write == rhs.write
    }
    
}
