//
//  ReadOnlyProperty.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//


/// A property that is readable.
public class ReadableProperty<ReturnValue>: @MainActor Equatable, PythonScriptConvertible {
    
    /// The closure for reading a property.
    let read: Closure
    
    /// The object to which the property is attached.
    let origin: MObject
    
    
    public var representation: String {
        "\(origin.identifier).\(self.read.representation)"
    }
    
    
    init(origin: MObject, read: Closure) {
        self.read = read
        self.origin = origin
    }
    
    
    @MainActor
    public static func == (_ lhs: ReadableProperty, _ rhs: ReadableProperty) -> Bool {
        lhs.origin === rhs.origin &&
        lhs.read == rhs.read
    }
    
}


extension ReadableProperty<Point>: PointProtocol { }
extension ReadableProperty<Double>: Number { }


extension ReadableProperty<Array<MObject>> {
    
    public subscript(index: Int) -> ReturnValue.Element {
        ReturnValue.Element(identifier: "\(self.representation)[\(index)]")
    }
    
}


extension ReadableProperty<Array<Group>> {
    
    public subscript(index: Int) -> ReturnValue.Element {
        ReturnValue.Element(identifier: "\(self.representation)[\(index)]")
    }
    
}
