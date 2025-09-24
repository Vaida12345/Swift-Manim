//
//  Polygram.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//




///// A generalized Polygon, allowing for disconnected sets of edges.
//public class Polygram: VMObject {
//    /// Creates a polygram by connecting the dots in sequence.
//    public init(vertices: [PointProtocol]) {
//        super.init(arguments: [(nil, "[\(vertices.map(\.representation).joined(separator: ", "))]")])
//    }
//    
//    required init(identifier: String) { super.init(identifier: identifier) }
//    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) { super.init(typeIdentifier, arguments: arguments) }
//    
//    /// Rounds off the corners of the Polygram.
//    ///
//    /// - Parameters:
//    ///   - radius: The curvature of the corners of the Polygram.
//    public func roundCorners(radius: (any Number)? = nil) -> Polygram {
//        let polygram = self.copied()
//        polygram.call("round_corners", arguments: [("radius", radius?.representation)])
//        return polygram
//    }
//    
//}
