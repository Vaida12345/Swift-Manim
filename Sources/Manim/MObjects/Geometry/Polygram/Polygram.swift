//
//  Polygram.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/14.
//




/// A generalized Polygon, allowing for disconnected sets of edges.
public class Polygram: VMObject {
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    /// Creates a polygram by connecting the dots in sequence.
    public init(vertices: [PointProtocol]) {
        super.init(args: [(nil, "[\(vertices.map(\.representation).joined(separator: ", "))]")])
    }
    
    override init(base: String? = nil, args: Closure.Arguments) {
        super.init(base: base, args: args)
    }
    
    /// Rounds off the corners of the Polygram.
    ///
    /// - Parameters:
    ///   - radius: The curvature of the corners of the Polygram.
    public func roundCorners(radius: Double? = nil) -> Polygram {
        let polygram = self.copied()
        polygram.call("round_corners", arguments: [("radius", radius?.description)])
        return polygram
    }
    
}
