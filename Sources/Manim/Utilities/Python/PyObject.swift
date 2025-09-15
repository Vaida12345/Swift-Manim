//
//  PyObject.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//


/// The base python class.
///
/// This class indicates that an object is callable in python. This structure does not provide ways to declare a python class.
//@dynamicMemberLookup
public class PyObject: Equatable, PythonScriptConvertible {
    
    internal let identifier: String
    
    internal let __base: String?
    
    internal let __args: Closure.Arguments?
    
    public var representation: String {
        self.identifier
    }
    
    
    internal func attribute(_ attributeName: String, to args: Closure.Arguments) {
        Generator.main.add("\(self.identifier).\(attributeName)\(args.representation)")
    }
    
    
    init(base: String? = nil, args: Closure.Arguments) {
        let base = base ?? "\(Self.self)"
        
        if shouldOverrideInit {
            self.identifier = ""
            self.__base = base
            self.__args = args
        } else {
            self.identifier = __formVariableName(base: base)
            Generator.main.add("\(self.identifier) = \(base)\(args.representation)")
            self.__base = nil
            self.__args = nil
        }
    }
    
    required init(identifier: String) {
        self.identifier = identifier
        self.__base = nil
        self.__args = nil
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
