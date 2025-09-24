//
//  FunctionGraph.swift
//
//
//  Created by Vaida on 2023/10/30.
//

import Foundation
import LaTeX


//public final class FunctionGraph: VMObject {
//    
//    public convenience init(color: Color? = nil, range: ClosedRange<Double>? = nil, function: (_ x: String) -> some LaTeXComponent) {
//        let symbol = "t"
//        let result = function(symbol)
//        
//        self.init(
//            arguments: [
//                (nil, "lambda t: \(result.pyDescription)"),
//                ("color", color?.representation),
//                ("range", range.map { "[\($0.lowerBound), \($0.upperBound), 1]" }),
//            ]
//        )
//    }
//    
//}
