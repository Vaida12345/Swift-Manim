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
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/scene_camera.mov)
    ///
    /// ```swift
    /// let dot = Dot()
    /// let plane = NumberPlane(margin: 2)
    ///
    /// let text = Text("(\(dot.x), \(dot.y))")
    /// text.addUpdater(initial: true) {
    ///     text.become(Text(dot.origin.description))
    ///     text.move(rightOf: dot)
    /// }
    /// scene.add(plane, dot, text)
    ///
    /// withAnimation(.linear, in: .parallel) {
    ///     dot.move(to: [1, 1])
    ///     scene.camera.move(to: [1, 1])
    /// }
    /// ```
    public let camera: MovingCamera
    
    
    /// The main scene proxy, internal use only.
    internal static var shared: SceneProxy {
        SceneProxy(scene: Manim.scene)
    }
    
    
    init(scene: PythonObject) {
        self.scene = scene
        self.camera = MovingCamera(scene.camera)
    }
    
    
    /// Freeze animation for `duration`.
    public func sleep(for duration: Duration = .seconds(1)) {
        let duration = Double(duration.components.attoseconds) / pow(10, 18) + Double(duration.components.seconds)
        scene.wait(duration)
    }
    
    /// Places `targets` next to each other on screen.
    public func arrange(_ targets: [MObject], direction: Direction, spacing: Double = 0.25) {
        let group = Group(targets)
        group.arrange(direction: direction, spacing: spacing)
    }
    
    /// Places `targets` next to each other on screen.
    public func arrange(_ targets: MObject..., direction: Direction, spacing: Double = 0.25) {
        self.arrange(targets, direction: direction, spacing: spacing)
    }
    
    /// The logical unit width of the screen
    public var width: Double {
        Double(manim.config.frame_width)!
    }
    
    /// The logical unit height of the screen
    public var height: Double {
        Double(manim.config.frame_height)!
    }
    
    /// Returns all mobjects which are not submobjects.
    public var topLevelObjects: [VMObject] {
        scene.get_top_level_mobjects().map(VMObject.init)
    }
    
    /// The time since the start of the scene.
    public var time: Double {
        Double(scene.renderer.time)!
    }
 
    /// Add the objects without animation.
    ///
    /// Objects that are added first are placed at the bottom.
    ///
    /// - SeeAlso: ``MObject/show(animation:)`` to add objects with animations.
    public func add(_ targets: MObject...) {
        self.add(targets)
    }
    
    /// Add the objects without animation.
    ///
    /// Objects that are added first are placed at the bottom.
    ///
    /// - SeeAlso: ``MObject/show(animation:)`` to add objects with animations.
    public func add(_ targets: [MObject]) {
        for target in targets {
            scene.add(target._pythonObject)
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
            scene.remove(target._pythonObject)
        }
    }
    
}
