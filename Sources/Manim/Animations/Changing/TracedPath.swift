//
//  TracedPath.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//


public class TracedPath: VMObject {
    
    
    public convenience init(point: ReadableProperty<Point>, width: Double = 2, color: Color = .white, duration: Double? = nil) {
        self.init(arguments: [
            ("traced_point_func", "\(point.origin.identifier).\(point.read.name)"),
            ("stroke_width", width.description),
            ("stroke_color", color.representation),
            ("dissipating_time", duration?.description)
        ])
    }
    
}
