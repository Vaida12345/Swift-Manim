//
//  Functions.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//

import Foundation


public func sleep(for duration: Duration) {
    Generator.main.add("self.wait(\(Double(duration.components.attoseconds) / pow(10, 18) + Double(duration.components.seconds)))")
}
