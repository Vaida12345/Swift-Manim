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
    ///
    /// ```swift
    /// let dot = Dot()
    ///
    /// let state = dot.save()
    /// dot.move(to: [2, 2])
    /// dot.color = .red
    ///
    /// withAnimation {
    ///     state.restore()
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/state_restore.mov)
    public func save() -> State {
        State(parent: self, copy: self.copied())  // note: this is how it is implemented in Python.
    }
    
}


/// The state of an `MObject`, including its position, color, and size.
///
/// You can restore a state with ``restore()``.
///
/// ```swift
/// let dot = Dot()
///
/// let state = dot.save()
/// dot.move(to: [2, 2])
/// dot.color = .red
///
/// withAnimation {
///     state.restore()
/// }
/// ```
///
/// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/state_restore.mov)
@MainActor
public struct State {
    
    let parent: MObject
    
    let copy: MObject
    
    /// Restores the saved state of `parent`
    ///
    /// ```swift
    /// let dot = Dot()
    ///
    /// let state = dot.save()
    /// dot.move(to: [2, 2])
    /// dot.color = .red
    ///
    /// withAnimation {
    ///     state.restore()
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/state_restore.mov)
    @discardableResult
    public func restore() -> AttachedAnimation {
        parent.become(copy) // note: this is how it is implemented in Python.
    }
    
    }
