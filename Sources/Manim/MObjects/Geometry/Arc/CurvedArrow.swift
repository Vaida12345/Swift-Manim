//
//  CurvedArrow.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//


import SwiftUI


public final class CurvedArrow: Arc {
    
    public override init(start: Point, end: Point, angle: Angle = .degrees(45)) {
        super.init(args: [
            ("start_point", start.representation),
            ("end_point", end.representation),
            ("angle", angle.radians.description),
        ])
    }
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
}
