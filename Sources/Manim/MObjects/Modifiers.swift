//
//  Modifiers.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//




extension MObject {
    
    /// The action of setting.
    ///
    /// When updating, if you pass a method as an argument, when the an ``Method/attached()`` ``Method`` is modified, the object will be updated to match the changes.
    ///
    /// ```swift
    /// let line = Line(start: Point(x: -2, y: 1), end: .center)
    /// let dot = Dot(point: Point(x: -2, y: 1))
    ///
    /// line.set.start(to: dot.center.attached())
    /// ```
    ///
    /// In this example, the `line` would change its start point whenever the coordinates of `dot` changes.
    public var set: SetAction {
        SetAction(base: self)
    }
    
    public final class SetAction {
        
        let base: MObject
        
        
        private func __set(name: String, args: Args) -> AttachedAnimation {
            AttachedAnimation(name: name, target: base.identifier, args: args)
        }
        
        private func __setWithUpdaters(_notCheckingName: String, args: Args) -> AttachedAnimation {
            let oldShouldUseAnimation = shouldUseAnimation
            shouldUseAnimation = false
            base.addUpdater { object in
                _ = object.set.__set(name: _notCheckingName, args: args)
            }
            shouldUseAnimation = oldShouldUseAnimation
            
            return AttachedAnimation(name: _notCheckingName, target: base.identifier, args: args)
        }
        
        private func __setWithUpdaters<Result>(name: String, args: Args, method: Method<Result>) -> AttachedAnimation {
            if !method.isDetached {
                return __setWithUpdaters(_notCheckingName: name, args: args)
            }
            
            return AttachedAnimation(name: name, target: base.identifier, args: args)
        }
        
        
        init(base: MObject) {
            self.base = base
        }
        
        
        /// Sets the start point.
        ///
        /// - Note: This method is not animated.
        @discardableResult
        public func start(to point: Point) -> AttachedAnimation {
            __set(name: "put_start_and_end_on", args: [(nil, point.pyDescription), (nil, "\(base.identifier).get_end()")])
        }
        
        /// Sets the start point.
        ///
        /// When an ``Method/attached()`` ``Method`` is modified, the object will be updated to match the changes.
        ///
        /// - Note: This method is not animated.
        @discardableResult
        public func start(to point: Method<Point>) -> AttachedAnimation {
            __setWithUpdaters(name: "put_start_and_end_on", args: [(nil, point.get()), (nil, "\(base.identifier).get_end()")], method: point)
        }
        
        /// Sets the end point.
        ///
        /// - Note: This method is not animated.
        @discardableResult
        public func end(to point: Point) -> AttachedAnimation {
            __set(name: "put_start_and_end_on", args: [(nil, "\(base.identifier).get_start()"), (nil, point.pyDescription)])
        }
        
        /// Sets the end point.
        ///
        /// When an ``Method/attached()`` ``Method`` is modified, the object will be updated to match the changes.
        ///
        /// - Note: This method is not animated.
        @discardableResult
        public func end(to point: Method<Point>) -> AttachedAnimation {
            __setWithUpdaters(name: "put_start_and_end_on", args: [(nil, "\(base.identifier).get_start()"), (nil, point.get())], method: point)
        }
        
        @discardableResult
        public func x(_ value: ValueTracker) -> AttachedAnimation {
            __setWithUpdaters(_notCheckingName: "set_x", args: [(nil, "\(value.identifier).get_value()")])
        }
        
        @discardableResult
        public func y(_ value: ValueTracker) -> AttachedAnimation {
            __setWithUpdaters(_notCheckingName: "set_x", args: [(nil, "\(value.identifier).get_value()")])
        }
        
    }
    
}
