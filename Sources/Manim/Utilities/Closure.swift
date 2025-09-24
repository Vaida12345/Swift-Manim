//
//  Closure.swift
//  Manim
//
//  Created by Vaida on 2025-09-24.
//

import PythonKit


@MainActor
struct Closure {
    
    let name: String
    
    var arguments: Arguments
    
    
    /// - Note: `nil` values are ignored by default.
    mutating func append(_ key: String, _ value: any PythonConvertible) {
        self.arguments.append(Argument(key, value))
    }
    
    
    init(name: String, arguments: Arguments = []) {
        self.name = name
        self.arguments = arguments
    }
    
    init(_ name: String, _ arguments: Arguments = []) {
        self.name = name
        self.arguments = arguments
    }
    
    
    @MainActor
    struct Arguments: @MainActor Collection, @MainActor ExpressibleByArrayLiteral {
        
        var contents: [Argument]
        
        
        var startIndex: Int { 0 }
        var endIndex: Int { contents.endIndex }
        func index(after i: Int) -> Int { i + 1 }
        subscript(position: Int) -> Argument {
            get { contents[position] }
            set { contents[position] = newValue }
        }
        @_disfavoredOverload
        mutating func append(_ newValue: Argument) {
            self.contents.append(newValue)
        }
        
        /// - Note: `nil` values are ignored by default.
        mutating func append(_ key: String, _ value: (any PythonConvertible)?) {
            if let value {
                self.contents.append(Argument(key, value))
            }
        }
        
        mutating func insert(_ key: String, _ value: (any PythonConvertible)?, at i: Int) {
            if let value {
                self.contents.insert(Argument(key, value), at: i)
            }
        }
        
        
        init(_ contents: [Argument] = []) {
            self.contents = contents
        }
        
        init(arrayLiteral elements: (String, (any PythonConvertible)?)...) {
            contents = elements.filter({ $0.1 != nil }).map({ Argument(key: $0, value: $1!) })
        }
        
        
        static func + (lhs: Arguments, rhs: Arguments) -> Arguments {
            Arguments(lhs.contents + rhs.contents)
        }
        
        
        enum Condition<T> {
            case notEqual(T)
        }
        
    }
    
    
    @MainActor
    struct Argument {
        
        let key: String
        
        let value: any PythonConvertible
        
        
        init(key: String, value: any PythonConvertible) {
            self.key = key
            self.value = value
        }
        
        init(_ key: String, _ value: any PythonConvertible) {
            self.key = key
            self.value = value
        }
        
    }
    
}


extension PythonObject {
    
    /// Alias for the function above that lets the caller dynamically construct the argument list, without using a dictionary literal.
    /// This function must be called explicitly on a `PythonObject` because `@dynamicCallable` does not recognize it.
    @discardableResult
    @MainActor
    func dynamicallyCall(withKeywordArguments args: Closure.Arguments) -> PythonObject {
        self.dynamicallyCall(withKeywordArguments: args.map({ ($0.key, $0.value) }))
    }
    
}
