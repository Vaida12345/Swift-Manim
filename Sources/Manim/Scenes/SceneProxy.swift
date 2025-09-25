//
//  SceneProxy.swift
//  Manim
//
//  Created by Vaida on 2025-09-24.
//

import Foundation
import PythonKit


/// The proxy for scene.
@MainActor
public struct SceneProxy {
    
    let scene: PythonObject
    
    /// The camera associated with the scene.
    ///
    /// You can use the suite that comes with ``Transformable`` to move the camera.
    ///
    /// ```swift
    /// withAnimation {
    ///     dot.move(to: [1, 1])
    ///     scene.camera.move(to: [1, 1])
    /// }
    /// ```
    ///
    /// In the example above, the dot remains at the center of the screen.
    public let camera: MovingCamera
    
    
    init(scene: PythonObject) {
        self.scene = scene
        self.camera = MovingCamera(scene.camera)
    }
    
    
    /// Freeze animation for `duration`.
    public func sleep(for duration: Duration = .seconds(1)) {
        let duration = Double(duration.components.attoseconds) / pow(10, 18) + Double(duration.components.seconds)
        scene.wait(duration)
    }
    
    public func arrange(_ targets: [MObject], direction: Direction, spacing: Double = 0.25) {
        let group = Group(targets)
        group.arrange(direction: direction, spacing: spacing)
    }
    
    public func arrange(_ targets: MObject..., direction: Direction, spacing: Double = 0.25) {
        self.arrange(targets, direction: direction, spacing: spacing)
    }
 
    /// Add the objects without animation.
    ///
    /// - SeeAlso: ``MObject/show(animation:)`` to add objects with animations.
    public func add(_ targets: MObject...) {
        self.add(targets)
    }
    
    /// Add the objects without animation.
    ///
    /// - SeeAlso: ``MObject/show(animation:)`` to add objects with animations.
    public func add(_ targets: [MObject]) {
        for target in targets {
            scene.add(target.pythonObject)
        }
    }
    
    /// Remove `targets` as sub object.
    ///
    /// - Note: This has no effect if `targets` is not a children of `self`.
    public func remove(_ targets: MObject...) {
        self.remove(targets)
    }
    
    /// Remove `targets` as sub object.
    ///
    /// - Note: This has no effect if `targets` is not a children of `self`.
    public func remove(_ targets: [MObject]) {
        for target in targets {
            scene.remove(target.pythonObject)
        }
    }
    
}
