//
//  MObject + State.swift
//  Manim
//
//  Created by Vaida on 2025-09-25.
//

import PythonKit


extension MObject {
    
    /// Save the current state (position, color & size).
    ///
    /// You can restore a state with ``State/restore()``.
    public func save() -> State {
        State(parent: self, copy: self.copied())  // note: this is how it is implemented in Python.
    }
    
    
    /// The state of an `MObject`, including its position, color, and size.
    @MainActor
    public struct State {
        
        let parent: MObject
        
        let copy: MObject
        
        /// Restores the state to `parent`
        public func restore() {
            parent.become(copy) // note: this is how it is implemented in Python.
        }
        
    }
    
}
