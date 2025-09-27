//
//  ValueTracker.swift
//  Manim
//
//  Created by Vaida on 8/26/24.
//

import PythonKit


/// A binding to a ``ValueTracker``.
///
/// You can use ``MObject/track(_:)`` that comes with syncing.
///
/// ```swift
/// let dot = Dot(color: .blue)
/// dot.show()
///
/// let x = dot.track(\.x)
/// withAnimation {
///     x += 1
/// }
/// ```
///
/// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/track.mov)
@propertyWrapper
public class Binding<T>: MObject where T: PythonConvertible & ConvertibleFromPython {
    
    let get: (() -> T)! // optional for `ValueTracker` to inherit from `Binding`.
    
    let set: ((T) -> Void)!
    
    /// The underlying value.
    public var wrappedValue: T {
        get { get() }
        set { set(newValue) }
    }
    
    /// Swift Syntax suger.
    ///
    /// Use `$wrappedValue` to access `self`.
    public var projectedValue: Binding<T> {
        self
    }
    
    init(get: @escaping () -> T, set: @escaping (T) -> Void) {
        self.get = get
        self.set = set
        
        super.init(manim.Mobject())
    }
    
    required init(_ pythonObject: PythonObject) {
        self.get = nil
        self.set = nil
        
        super.init(pythonObject)
    }
    
}
