//
//  Closure.swift
//  Manim
//
//  Created by Vaida on 2025-09-15.
//


public struct Closure: PythonScriptConvertible, Equatable {
    
    let name: String
    
    let arguments: Arguments
    
    
    init(name: String, arguments: Arguments) {
        self.name = name
        self.arguments = arguments
    }
    
    init(_ name: String, _ arguments: Arguments) {
        self.name = name
        self.arguments = arguments
    }
    
    
    public var representation: String {
        return self.name + self.arguments.representation
    }
    
    
    public struct Arguments: Equatable, Collection, ExpressibleByArrayLiteral, PythonScriptConvertible {
        
        var contents: [Argument]
        
        
        public var startIndex: Int { 0 }
        public var endIndex: Int { contents.endIndex }
        public func index(after i: Int) -> Int { i + 1 }
        public subscript(position: Int) -> Argument {
            get { contents[position] }
            set { contents[position] = newValue }
        }
        public mutating func append(_ newValue: Argument) {
            self.contents.append(newValue)
        }
        
        public mutating func append(_ key: String?, _ value: String?) {
            self.contents.append(Argument(key, value))
        }
        
        
        public var representation: String {
            "(\(self.filter { $0.value != nil }.map { "\($0.key == nil ? "" : "\($0.key!)=")\($0.value!)" }.joined(separator: ", ")))"
        }
        
        
        public init(_ contents: [Argument]) {
            self.contents = contents
        }
        
        public init(arrayLiteral elements: (String?, String?)...) {
            contents = elements.map({ Argument(key: $0, value: $1) })
        }
        
        
        public static func + (lhs: Arguments, rhs: Arguments) -> Arguments {
            Arguments(lhs.contents + rhs.contents)
        }
        
    }
    
    
    
    public struct Argument: Equatable {
        
        let key: String?
        
        let value: String?
        
        
        init(key: String?, value: String?) {
            self.key = key
            self.value = value
        }
        
        init(_ key: String?, _ value: String?) {
            self.key = key
            self.value = value
        }
        
    }
    
}
