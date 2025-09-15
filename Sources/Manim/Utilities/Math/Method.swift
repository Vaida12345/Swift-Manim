//
//  Method.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/8.
//


public class Method<ReturnValue>: Equatable {
    
    let name: String
    
    let args: Args
    
    let parent: MObject
    
    let isDetached: Bool
    
    
    internal func get() -> String {
        "\(parent.identifier).\(name)\(__formArgs(args))"
    }
    
    /// Attach the method. Any modifications to this method will result in updating objects using this object.
    ///
    /// In this example,
    ///
    /// ```swift
    /// let line = Line(start: Point(x: -2, y: 1), end: Point(x: 0, y: -2))
    /// let dot = Dot(point: Point(x: -2, y: 1))
    ///
    /// dot.show(animation: .fadeIn())
    /// line.show(animation: .rotate())
    ///
    /// line.set.start(to: dot.center.attached())
    ///
    /// withAnimation {
    ///     dot.move(to: .center)
    /// }
    /// ```
    ///
    /// At `dot.move(to: .center)`, the dot is moved to the center of screen. As the start of the `line` is bound to `dot.center`, hence when the dot is moving, so is the line.
    public func attached() -> Method<ReturnValue> {
        Method<ReturnValue>(name: name, args: args, parent: parent, isDetached: false)
    }
    
    
    init(name: String, args: Args, parent: MObject, isDetached: Bool = true) {
        self.name = name
        self.args = args
        self.parent = parent
        self.isDetached = isDetached
    }
    
    
    public static func == (lhs: Method<ReturnValue>, rhs: Method<ReturnValue>) -> Bool {
        lhs.name == rhs.name &&
        lhs.args.count == rhs.args.count &&
        lhs.parent == rhs.parent &&
        lhs.isDetached == rhs.isDetached
    }
    
}


public final class TrackableMethod<ReturnValue>: Method<ReturnValue> {
    
    let trackingName: String
    
    init(name: String, args: Args, parent: MObject, trackingName: String) {
        self.trackingName = trackingName
        
        super.init(name: name, args: args, parent: parent)
    }
    
    public func tracked() -> ValueTracker<ReturnValue> {
        if let tracker = parent.store[name] as? ValueTracker<ReturnValue> {
            return tracker
        } else {
            let value = ValueTracker(value: self)
            let _ = parent.set.__setWithUpdaters(_notCheckingName: trackingName, args: [(nil, "\(value.identifier).get_value()")])
            parent.store[name] = value
            return value
        }
    }
}
