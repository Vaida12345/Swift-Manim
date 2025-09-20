//
//  MObject + State.swift
//  Manim
//
//  Created by Vaida on 2025-09-20.
//


extension MObject {
    
    /// Controls the states.
    ///
    /// You can use ``State/save`` and ``State/restore`` to save and restore states.
    public var state: State {
        State(base: self)
    }
    
    
    @MainActor
    public final class State {
        
        let base: MObject
        
        init(base: MObject) {
            self.base = base
        }
        
        /// Save the states of the object.
        public func save() {
            Generator.main.add("\(base.identifier).save_state()")
        }
        
        /// Transforms an object to its last saved state, ``save()``.
        @discardableResult
        public func restore() -> Animation {
            ActionAnimation(name: "Restore", args: []).makeAnimation(object: base)
        }
    }
    
}
