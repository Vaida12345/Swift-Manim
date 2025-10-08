//
//  AlwaysRedraw.swift
//  Manim
//
//  Created by Vaida on 2025-10-08.
//

/// Redraws an `MObject` every frame using the provided generator function.
///
/// This function constructs an `MObject` and attaches an updater that continuously regenerates it according to the supplied closure. The returned object automatically updates its appearance each frame, ensuring it always reflects the most recent output of `makeMObject`.
///
/// - Parameter makeMObject: A closure that produces a new `MObject` each frame.
/// - Returns: An `MObject` that continuously redraws itself using the generator.
/// - Note: The closure is stored and executed repeatedly, so it should be efficient and side-effect-free where possible.
@MainActor
public func alwaysRedraw<T>(using makeMObject: @escaping () -> T) -> T where T: MObject {
    let object = makeMObject()
    object.addUpdater {
        object.become(makeMObject()) // this is how it is implemented in Python.
    }
    return object
}
