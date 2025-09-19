//
//  CubicBezier.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//




/// A bezier
final class CubicBezier: VMObject {
    
    /// Creates a bezier using the coordinates of `anchor` and `handle`.
    public convenience init(start: (anchor: Point, handle: Point), end: (anchor: Point, handle: Point)) {
        self.init(arguments: [
            ("start_anchor", start.anchor.representation),
            ("start_handle", start.handle.representation),
            ("end_anchor",   end.anchor.representation),
            ("end_handle",   end.handle.representation),
        ])
    }
    
}
