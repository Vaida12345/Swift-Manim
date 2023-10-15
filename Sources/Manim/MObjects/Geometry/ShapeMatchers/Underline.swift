//
//  Underline.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/15.
//

import Foundation


final class Underline: Line {
    
    /// Creates an underline.
    public init(base: MObject, padding: Double? = nil) {
        super.init(args: [
            ("mobject", base.identifier),
            ("buff", padding?.description),
        ])
    }
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
}


extension MObject {
    
    func underline(padding: Double? = nil) -> Underline {
        Underline(base: self, padding: padding)
    }
    
}
