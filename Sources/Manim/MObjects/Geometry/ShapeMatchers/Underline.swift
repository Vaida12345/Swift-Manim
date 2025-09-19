//
//  Underline.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//




final class Underline: Line {
    
    /// Creates an underline.
    public init(base: MObject, padding: Double? = nil) {
        super.init(arguments: [
            ("mobject", base.identifier),
            ("buff", padding?.description),
        ])
    }
    
    required init(identifier: String) { super.init(identifier: identifier) }
    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) { super.init(typeIdentifier, arguments: arguments) }
}


extension MObject {
    
    func underline(padding: Double? = nil) -> Underline {
        Underline(base: self, padding: padding)
    }
    
}
