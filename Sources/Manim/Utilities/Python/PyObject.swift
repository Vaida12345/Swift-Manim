//
//  PyObject.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import Foundation


/// The base python class.
public class PyObject: Equatable {
    
    internal let identifier: String
    
    
    internal func attribute(_ attributeName: String, to args: [(key: String?, value: String?)]) {
        Generator.main.add("\(self.identifier).\(attributeName)\(__formArgs(args))")
    }
    
    
    init(base: String? = nil, args: Args) {
        let base = base ?? "\(Self.self)"
        self.identifier = __formVariableName(base: base)
        Generator.main.add("\(self.identifier) = \(base)\(__formArgs(args))")
    }
    
    required init(identifier: String) {
        self.identifier = identifier
    }
    
    
    public static func == (lhs: PyObject, rhs: PyObject) -> Bool {
        lhs.identifier == rhs.identifier
    }
}


internal typealias Args = [(key: String?, value: String?)]


internal func __formArgs(_ args: Args) -> String {
    "(\(args.filter { $0.value != nil }.map { "\($0.key == nil ? "" : "\($0.key!)=")\($0.value!)" }.joined(separator: ", ")))"
}


func __formVariableName(base: String) -> String {
    var base = base
    base.replaceSubrange(base.startIndex..<base.index(after: base.startIndex), with: base[base.startIndex].lowercased())
    let index = variableCounter[base, default: 1]
    variableCounter[base, default: 1] += 1
    if index > 1 {
        base.append(index.description)
    }
    return base
}
