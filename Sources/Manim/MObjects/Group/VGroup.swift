//
//  VGroup.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//




/// A group of vectorized ``MObject``.
public class VGroup: VMObject {
    
    public func arrange(direction: Direction, spacing: Double = 1) {
        Generator.main.add("\(self.identifier).arrange(\(direction.pyDescription), buff=\(spacing))")
    }
    
    
    required init(identifier: String) { super.init(identifier: identifier) }
    
    public convenience init(_ children: MObject...) {
        self.init(children)
    }
    
    public init(_ children: [MObject]) {
        super.init(base: "VGroup", args: children.map(\.identifier).map { (nil, $0) })
    }
    
    override init(base: String? = nil, args: Args) {
        super.init(base: base, args: args)
    }
    
}
