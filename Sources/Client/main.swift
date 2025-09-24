//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim
import Foundation


try await withManim { scene in
//    NumberPlane(domain: .init(max: 3, step: 2)).show()
    
//    let graph = FunctionGraph(range: .init(max: 3, step: 2)) { x in
//        x + 2
//    }
    
//    graph.show()
} configuration: { configuration in
    configuration.preview = false
    configuration.disableCache = true
}
