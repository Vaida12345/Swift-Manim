//
//  TracedPath.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//


//public class TracedPath: VMObject {
//    
//    
//    /// Traces the path of a point returned by a property call.
//    ///
//    /// - Parameters:
//    ///   - point: The property to be traced.
//    ///   - strokeWidth: The width of the trace.
//    ///   - color: The color of the trace.
//    ///   - dissipatingTime: The time taken for the path to dissipate. Default set to `nil` which disables dissipation.
//    public convenience init(point: ReadableProperty<Point>, strokeWidth: Double = 2, color: Color = .white, dissipatingTime: Double? = nil) {
//        self.init(arguments: [
//            ("traced_point_func", "\(point.origin.identifier).\(point.read.name)"),
//            ("stroke_width", strokeWidth.representation),
//            ("stroke_color", color.representation),
//            ("dissipating_time", dissipatingTime?.description)
//        ])
//    }
//    
//}
