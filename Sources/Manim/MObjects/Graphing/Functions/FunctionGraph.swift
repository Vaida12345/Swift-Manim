//
//  FunctionGraph.swift
//
//
//  Created by Vaida on 2023/10/30.
//

import Foundation
import LaTeX


public final class FunctionGraph: VMObject {
    
    public init(function: (_ x: String) -> some LaTeXComponent) {
        let symbol = "t"
        let result = function(symbol)
        
        super.init(args: [(nil, "lambda t: \(result.pyDescription)")])
    }
    
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
}
