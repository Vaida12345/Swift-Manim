//
//  CubicBezier.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//




/// A bezier
final class CubicBezier: VMObject {
    
    /// Creates a bezier using the coordinates of `anchor` and `handle`.
    public init(start: (anchor: Point, handle: Point), end: (anchor: Point, handle: Point)) {
        super.init(args: [
            ("start_anchor", start.anchor.pyDescription),
            ("start_handle", start.handle.pyDescription),
            ("end_anchor",   end.anchor.pyDescription),
            ("end_handle",   end.handle.pyDescription),
        ])
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    
}
