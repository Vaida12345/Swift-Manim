//
//  Group.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//


/// A group of vectorized ``MObject``.
public class Group: VMObject, @MainActor Collection {
    
    let children: [MObject]
    
    public var startIndex: Int { 0 }
    public var endIndex: Int { self.children.endIndex }
    public func index(after i: Int) -> Int { i + 1 }
    public subscript(position: Int) -> MObject {
        self.children[position]
    }
    
    public func arrange(direction: Direction, spacing: Double = 0.25) {
        var arguments = Closure.Arguments()
        arguments.append(nil, direction.representation)
        arguments.append("buff", spacing.description, when: .notEqual("0.25"))
        
        Manim.Generator.main.add("\(self.identifier).arrange\(arguments.representation)")
    }
    
    public init(_ children: [MObject]) {
        self.children = children
        super.init("Group", arguments: .init(children.map(\.identifier).map { .init(nil, $0) }))
    }
    
    public convenience init(_ children: MObject...) {
        self.init(children)
    }
    
    required init(identifier: String) { self.children = []; super.init(identifier: identifier) }
    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) { self.children = []; super.init(typeIdentifier, arguments: arguments) }
    
}
