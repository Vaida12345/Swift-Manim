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
public final class SceneProxy {
    
    let scene: PythonObject
    
    
    init(scene: PythonObject) {
        self.scene = scene
    }
    
    
    /// Freeze animation for `duration`.
    public func sleep(for duration: Duration) {
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
        for target in targets {
            scene.add(target)
        }
    }
    
}
