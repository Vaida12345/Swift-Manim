//
//  ReadWriteProperty.swift
//  Manim
//
//  Created by Vaida on 2025-09-15.
//


/// Properties that can both read from and write to.
public final class ReadWriteProperty<Value>: ReadableProperty<Value> {
    
    /// The function name for writing a property.
    let write: String
    
    /// The presence of a value means it is a user-set compile-time constant Swift value.
    let value: Value?
    
    
    public override var representation: String {
        if let value {
            Manim.representation(of: value)
        } else {
            super.representation
        }
    }
    
    
    init(origin: MObject, read: Closure, write: String) {
        self.write = write
        self.value = nil
        super.init(origin: origin, read: read)
    }
    
    init(constant: Value) {
        self.value = constant
        self.write = ""
        super.init(origin: MObject(identifier: ""), read: Closure("", []))
    }
    
    
    @MainActor
    public static func == (_ lhs: ReadWriteProperty, _ rhs: ReadWriteProperty) -> Bool {
        var valuesEqual: Bool {
            if let lhs = lhs.value {
                if let rhs = rhs.value {
                    return Manim.representation(of: lhs) == Manim.representation(of: rhs)
                } else {
                    return false
                }
            } else {
                return rhs.value == nil
            }
        }
        
        return lhs.origin === rhs.origin &&
        lhs.read == rhs.read &&
        lhs.write == rhs.write &&
        valuesEqual
    }
    
}


extension ReadWriteProperty {
    
    /// Updates this property to `other`.
    @discardableResult
    public func update(to newValue: Value) -> AttachedAnimation {
        assert(value == nil, "You should not modify a constant.")
        
        let args = Closure.Arguments([Closure.Argument(nil, Manim.representation(of: newValue))])
        return AttachedAnimation(name: self.write, target: self.origin.identifier, args: args)
    }
    
    /// Updates this property to the current value of `other`.
    @discardableResult
    public func update(to other: ReadableProperty<Value>) -> AttachedAnimation {
        assert(value == nil, "You should not modify a constant.")
        
        let args = Closure.Arguments([Closure.Argument(nil, other.representation)])
        return AttachedAnimation(name: self.write, target: self.origin.identifier, args: args)
    }
    
    /// Binds and continuous updates this property to the value of `other`.
    ///
    /// This method essentially [observes](``MObject/addUpdater(index:initialCall:handler:)``) and updates changes.
    ///
    /// ```swift
    /// let dot1 = Dot(at: [2, 2], color: .blue)
    /// let dot2 = Dot(at: .center, color: .green)
    ///
    /// dot1.show()
    /// dot2.show()
    ///
    /// withAnimation {
    ///     dot1.x.bind(to: dot2.x)
    ///     dot2.move(to: [-2, 0])
    /// }
    /// ```
    ///
    /// In the example above, the `x`-coordinate of `dot1` is bound to the `x`-coordinate of `dot2`, and `dot1` moves as `dot2` changes its `x`-coordinate.
    @discardableResult
    public func bind(to other: ReadableProperty<Value>) -> AttachedAnimation {
        assert(value == nil, "You should not modify a constant.")
        assert(!(other is ReadWriteProperty<Value>) || (other as! ReadWriteProperty<Value>).value == nil, "You should not bind to a constant.")
        
        let args = Closure.Arguments([Closure.Argument(nil, other.representation)])
        self.origin.addUpdater { object in
            Generator.main.add("\(self.origin.identifier).\(self.write)\(args.representation)")
        }
        return AttachedAnimation(name: self.write, target: self.origin.identifier, args: args)
    }
    
}


extension ReadWriteProperty {
    
    /// Creates a ``ValueTracker`` that can be manipulated easily.
    ///
    /// You can use `tracker` to change any property of an object. For example, you can change the `x`-coordinate of a dot.
    ///
    /// ```swift
    /// let tracker = dot2.x.tracker()
    ///
    /// withAnimation {
    ///     tracker += 5
    /// }
    /// ```
    public func tracker() -> ValueTracker<Value> {
        assert(value == nil, "You should not track (and hence modify) a constant.")
        
        let tracker = ValueTracker(value: self)
        let args = Closure.Arguments([Closure.Argument(nil, "\(tracker.value.representation)")])
        self.origin.addUpdater { object in
            Generator.main.add("\(self.origin.identifier).\(self.write)\(args.representation)")
        }
        return tracker
    }
}
