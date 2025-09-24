//
//  Matrix.swift
//  Manim
//
//  Created by Vaida on 2025-09-23.
//


//public class Matrix: VMObject {
//    
//    /// The left and right brackets, packed in an array.
//    public var brackets: ReadableProperty<Array<MObject>> {
//        ReadableProperty(origin: self, read: Closure("get_brackets", []))
//    }
//    
//    public var rows: ReadableProperty<Array<Group>> {
//        ReadableProperty(origin: self, read: Closure("get_rows", []))
//    }
//    
//    public var columns: ReadableProperty<Array<Group>> {
//        ReadableProperty(origin: self, read: Closure("get_columns", []))
//    }
//    
//    /// The entries of the matrix, in row-major order.
//    public var entries: ReadableProperty<Array<Group>> {
//        ReadableProperty(origin: self, read: Closure("get_entries", []))
//    }
//    
//    public init(_ lists: [[Any]], leftBracket: String = "[", rightBracket: String = "]") {
//        var arguments = Closure.Arguments()
//        let _list = lists.map({ "[" + $0.map(representation(of:)).joined(separator: ", ") + "]" })
//        arguments.append(nil, "[" + _list.joined(separator: ", ") + "]")
//        arguments.append("left_bracket", leftBracket, when: .notEqual("["))
//        arguments.append("right_bracket", rightBracket, when: .notEqual("]"))
//        
//        super.init(arguments: arguments)
//    }
//    
//    required init(identifier: String) { super.init(identifier: identifier) }
//    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) { super.init(typeIdentifier, arguments: arguments) }
//    
//}
