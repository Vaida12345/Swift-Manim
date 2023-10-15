//
//  TracedPath.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import Foundation


public class TracedPath: VMObject {
    
    
    public init(point: Method<Point>, width: Double = 2, color: Color = .white, duration: Double? = nil) {
        super.init(args: [
            ("traced_point_func", "\(point.parent.identifier).\(point.name)"),
            ("stroke_width", width.description),
            ("stroke_color", color.pyDescription),
            ("dissipating_time", duration?.description)
        ])
    }
    
    required init(identifier: String) {
        fatalError("init() has not been implemented")
    }
    
}
