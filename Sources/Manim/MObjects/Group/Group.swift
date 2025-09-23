//
//  Group.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//


/// A group of vectorized ``MObject``.
public class Group: VMObject {
    
    public func arrange(direction: Direction, spacing: (any Number) = 0.25) {
        var arguments = Closure.Arguments()
        arguments.append(nil, direction.representation)
        arguments.append("buff", spacing.representation, when: .notEqual("0.25"))
        
        Manim.Generator.main.add("\(self.identifier).arrange\(arguments.representation)")
    }
    
    public init(_ children: [MObject]) {
        super.init("Group", arguments: .init(children.map(\.identifier).map { .init(nil, $0) }))
    }
    
    @_disfavoredOverload
    public convenience init(_ children: MObject...) {
        self.init(children)
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) { super.init(typeIdentifier, arguments: arguments) }
    
}
