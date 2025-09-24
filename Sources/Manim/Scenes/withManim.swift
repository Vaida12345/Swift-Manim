//
//  withManim.swift
//  Manim
//
//  Created by Vaida on 2025-09-24.
//

import PythonKit


/// The entry point for all `Manim` animations.
///
/// Different to the Manim implementation, this package allows only one scene.
///
/// ```swift
/// try await withManim {
///     Dot().show()
/// }
/// ```
///
/// - Parameters:
///   - scene: The constructor for scene.
///   - configuration: The constructor for configurations.
@MainActor
public func withManim(
    scene: (SceneProxy) async throws -> Void,
    configuration: (ConfigurationProxy) async throws -> Void = { _ in },
) async throws {
    
    // MARK: - Configuration
    
    let configProxy = ConfigurationProxy()
    try await configuration(configProxy)
    if let libraryPath = configProxy.pythonLibraryPath {
        PythonLibrary.useLibrary(at: libraryPath.path)
    }
    
    let sys = Python.import("sys")
    if let packagesPath = configProxy.pythonPackagesPath {
        sys.path.append(packagesPath.path)
    }
    
    _manim = try Python.attemptImport("manim")
    defer { _manim = nil }
    
    
    let config = manim.config
    config["background_color"] = configProxy.backgroundColor.pythonObject
    config["background_opacity"] = configProxy.backgroundOpacity.pythonObject
    
    config["media_dir"] = configProxy.mediaDirectory.path.pythonObject
    config["save_sections"] = configProxy.saveSections.pythonObject
    config["output_file"] = "\(configProxy.mediaDirectory)/\(configProxy.fileName)".pythonObject
    config["format"] = configProxy.format.rawValue.pythonObject
    config["movie_file_extension"] = ("." + configProxy.format.rawValue).pythonObject
    if let frameRate = configProxy.frameRate {
        config["frame_rate"] = frameRate.pythonObject
    }
    if let localWidth = configProxy.localWidth {
        config["frame_width"] = localWidth.pythonObject
    }
    if let size = configProxy.size {
        config["pixel_height"] = Int(size.height).pythonObject
        config["pixel_width"] = Int(size.width).pythonObject
    }
    if configProxy.frameRate == nil && configProxy.size == nil,
       let quality = configProxy.quality {
        config["quality"] = quality.rawValue.pythonObject
    }
    config["renderer"] = configProxy.renderer.rawValue.pythonObject
    config["disable_caching"] = configProxy.disableCache.pythonObject
    
    
    // MARK: - Global scene
    let constructFunc: PythonFunction = PythonFunction { args, kwargs in
        return Python.None
    }
    
    // Use Python's type() to create a subclass of Scene
    let DynamicScene = Python.type(
        "DynamicScene", // name
        Python.tuple([manim.MovingCameraScene]), // base classes
        ["construct": constructFunc]  // methods
    )
    
    _scene = DynamicScene()
    defer { _scene = nil }
    
    let sceneProxy = SceneProxy(scene: _scene!)
    try await scene(sceneProxy)
    
    _scene!.render(preview: configProxy.preview)
}
