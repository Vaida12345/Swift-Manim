//
//  ReadWriteProperty.swift
//  Manim
//
//  Created by Vaida on 2025-09-15.
//


/// Properties that can both read from and write to.
public final class ReadWriteProperty<Value>: ReadableProperty<Value> {
    
    /// The closure for writing a property.
    let write: Closure
    
    init(origin: MObject, read: Closure, write: Closure) {
        self.write = write
        super.init(origin: origin, read: read)
    }
    
    
    @MainActor
    public static func == (_ lhs: ReadWriteProperty, _ rhs: ReadWriteProperty) -> Bool {
        lhs.origin === rhs.origin &&
        lhs.read == rhs.read &&
        lhs.write == rhs.write
    }
    
}


extension ReadWriteProperty {
    
    /// Updates this property to the current value of `other`.
    @discardableResult
    public func update(to other: ReadableProperty<Value>) -> AttachedAnimation {
        let args = Closure.Arguments([Closure.Argument(nil, "\(other.origin.identifier).\(other.read.representation)")] + self.write.arguments)
        return AttachedAnimation(name: self.write.name, target: self.origin.identifier, args: args)
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
        let args = Closure.Arguments([Closure.Argument(nil, "\(other.origin.identifier).\(other.read.representation)")] + self.write.arguments)
        self.origin.addUpdater { object in
            Generator.main.add("\(self.origin.identifier).\(self.write.name)\(args.representation)")
        }
        return AttachedAnimation(name: self.write.name, target: self.origin.identifier, args: args)
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
        let tracker = ValueTracker(value: self)
        let args = Closure.Arguments([Closure.Argument(nil, "\(tracker.value.representation)")] + self.write.arguments)
        self.origin.addUpdater { object in
            Generator.main.add("\(self.origin.identifier).\(self.write.name)\(args.representation)")
        }
        return tracker
    }
    
}
