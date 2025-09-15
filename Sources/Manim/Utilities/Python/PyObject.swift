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
public class PyObject: Equatable {
    
    internal let identifier: String
    
    internal let __base: String?
    
    internal let __args: Args?
    
    
    internal func attribute(_ attributeName: String, to args: [(key: String?, value: String?)]) {
        Generator.main.add("\(self.identifier).\(attributeName)\(__formArgs(args))")
    }
    
    
    init(base: String? = nil, args: Args) {
        let base = base ?? "\(Self.self)"
        
        if shouldOverrideInit {
            self.identifier = ""
            self.__base = base
            self.__args = args
        } else {
            self.identifier = __formVariableName(base: base)
            Generator.main.add("\(self.identifier) = \(base)\(__formArgs(args))")
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
    
    @dynamicCallable
    public struct MethodCalling {
        
        let methodName: String
        
        public func dynamicallyCall(withKeywordArguments pairs: KeyValuePairs<String, String>) {
            Generator.main.add("\(methodName)\(__formArgs(Array(pairs)))")
        }
        
        public func dynamicallyCall(withArguments args: Args) {
            Generator.main.add("\(methodName)\(__formArgs(args))")
        }
        
    }
}


public typealias Args = [(key: String?, value: String?)]


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

extension Args {
    
    var pyDescription: String {
        "{\(self.filter { $0.key != nil && $0.value != nil }.map { "\"\($0.key!)\":" + $0.value! }.joined(separator: ", "))}"
    }
    
}
