//
//  CurvedDoubleArrow.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//


import SwiftUI


public final class CurvedDoubleArrow: Arc {
    
    public override init(start: Point, end: Point, angle: Angle = .degrees(45)) {
        super.init(args: [
            ("start_point", start.pyDescription),
            ("end_point", end.pyDescription),
            ("angle", angle.radians.description),
        ])
    }
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
}
