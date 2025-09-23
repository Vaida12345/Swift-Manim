//
//  Closure.swift
//  Manim
//
//  Created by Vaida on 2025-09-15.
//


struct Closure: PythonScriptConvertible, @MainActor Equatable {
    
    let name: String
    
    /// `nil` means it is not callable.
    var arguments: Arguments?
    
    
    init(name: String, arguments: Arguments?) {
        self.name = name
        self.arguments = arguments
    }
    
    init(_ name: String, _ arguments: Arguments?) {
        self.name = name
        self.arguments = arguments
    }
    
    
    var representation: String {
        if let arguments {
            return self.name + arguments.representation
        } else {
            return self.name
        }
    }
    
    
    struct Arguments: @MainActor Equatable, @MainActor Collection, @MainActor ExpressibleByArrayLiteral, PythonScriptConvertible {
        
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
        mutating func append(_ key: String? = nil, _ value: String?, when condition: Condition<String>? = nil) {
            switch condition {
            case .notEqual(let string):
                if string != value {
                    fallthrough
                } else {
                    return
                }
                
            default:
                self.contents.append(Argument(key, value))
            }
        }
        
        mutating func append<T>(_ key: String? = nil, _ value: (T)?, when condition: Condition<T>? = nil) where T: PythonScriptConvertible {
            let transform: Condition<String>?
            switch condition {
            case .notEqual(let t):
                transform = .notEqual(t.representation)
            case nil:
                transform = nil
            }
            
            self.append(key, value?.representation, when: transform)
        }
        
        
        var representation: String {
            "(\(self.filter { $0.value != nil }.map { "\($0.key == nil ? "" : "\($0.key!)=")\($0.value!)" }.joined(separator: ", ")))"
        }
        
        
        init(_ contents: [Argument] = []) {
            self.contents = contents
        }
        
        init(arrayLiteral elements: (String?, String?)...) {
            contents = elements.map({ Argument(key: $0, value: $1) })
        }
        
        
        static func + (lhs: Arguments, rhs: Arguments) -> Arguments {
            Arguments(lhs.contents + rhs.contents)
        }
        
        
        enum Condition<T> {
            case notEqual(T)
        }
        
    }
    
    
    @MainActor
    struct Argument: @MainActor Equatable {
        
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
