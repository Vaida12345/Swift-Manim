//
//  PyObject.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//


/// The base python class.
///
/// Each instance of this class represents an instance that exists in Python script.
//@dynamicMemberLookup
public class PyObject: @MainActor Equatable, PythonScriptConvertible {
    
    /// The identifier of the Python instance.
    internal let identifier: String
    
    /// The identifier of the type
    internal let typeIdentifier: String?
    
    /// The arguments to construct the type.
    internal let arguments: Closure.Arguments?
    
    public var representation: String {
        self.identifier
    }
    
    
    /// Makes a python function call.
    internal func call(_ attributeName: String, arguments args: Closure.Arguments) {
        Generator.main.add("\(self.identifier).\(attributeName)\(args.representation)")
    }
    
    
    /// Creates an instance with the initializer.
    ///
    /// - Parameters:
    ///   - base: The class name in Python. Pass `nil` if you want to use the Swift class name.
    ///   - args: The arguments passed to the Python class initializer.
    ///
    /// This initializer creates an identifier of the newly created Python instance for you.
    required init(_ typeIdentifier: String? = nil, arguments: Closure.Arguments) {
        let base = typeIdentifier ?? "\(Self.self)"
        
        if shouldOverrideInit {
            self.identifier = ""
            self.typeIdentifier = base
            self.arguments = arguments
        } else {
            self.identifier = __formVariableName(base: base)
            Generator.main.add("\(self.identifier) = \(base)\(arguments.representation)")
            self.typeIdentifier = nil
            self.arguments = nil
        }
    }
    
    /// Links the instance with an existing Python instance using its identifier.
    required init(identifier: String) {
        self.identifier = identifier
        self.typeIdentifier = nil
        self.arguments = nil
    }
    
    internal init(identifier: String, typeIdentifier: String? = nil, arguments: Closure.Arguments? = nil) {
        self.identifier = identifier
        self.typeIdentifier = typeIdentifier
        self.arguments = arguments
    }
    
    
    public static func == (lhs: PyObject, rhs: PyObject) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
//    public subscript(dynamicMember dynamicMember: String) -> MethodCalling {
//        MethodCalling(methodName: dynamicMember)
//    }
    
//    @dynamicCallable
//    public struct MethodCalling {
//        
//        let methodName: String
//        
//        public func dynamicallyCall(withKeywordArguments pairs: KeyValuePairs<String, String>) {
//            Generator.main.add("\(methodName)\(__formArgs(Array(pairs)))")
//        }
//        
//        public func dynamicallyCall(withArguments args: Args) {
//            Generator.main.add("\(methodName)\(__formArgs(args))")
//        }
//        
//    }
}


@MainActor
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
