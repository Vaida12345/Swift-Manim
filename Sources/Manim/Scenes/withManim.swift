//
//  withManim.swift
//  Manim
//
//  Created by Vaida on 2025-09-24.
//

import PythonKit
import OSLog


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
    scene: @MainActor (SceneProxy) async throws -> Void,
    configuration: @MainActor (ConfigurationProxy) async throws -> Void = { _ in },
) async throws {
    
    // MARK: - Configuration
    
    let logger = Logger(subsystem: "Manim", category: "Initialization")
    let configProxy = ConfigurationProxy()
    try await configuration(configProxy)
    if let libraryPath = configProxy.pythonLibraryPath {
        precondition(libraryPath.exists, "Cannot find Python library at \(libraryPath), please double check the file path.")
        PythonLibrary.useLibrary(at: libraryPath.path)
    }
    
    logger.info("Using Python \(Python.version)")
    
    // setup packages
    let os = Python.import("os")
    let sys = Python.import("sys")
    
    let stdlib = String(os.path.dirname(Python.getattr(sys, "executable")))! + "/../lib/python" + String(Int(sys.version_info.major)!) + "." + String(Int(sys.version_info.minor)!)
    let dynload = stdlib + "/lib-dynload"
    let sitePackages = stdlib + "/site-packages"
    
    sys.path = [stdlib, dynload, sitePackages].pythonObject
    
    if let packagesPath = configProxy.pythonPackagesPath {
        precondition(packagesPath.exists, "Cannot find python packages, please follow README to setup environment.")
        sys.path.append(packagesPath.path)
    }
    
    if let latex = configProxy.latexPath {
        precondition(latex.exists, "Cannot find latex compiler, please follow README to setup environment.")
    }
    
    // override latex path
    let code = """
    import subprocess
    from functools import wraps
    
    # Save original subprocess.run
    _original_run = subprocess.run
    
    # Patch subprocess.run
    def patched_run(args, *popenargs, **kwargs):
        if args[0] == "latex":
            args[0] = "\(configProxy.latexPath?.path ?? "latex")"
        elif args[0] == "dvisvgm":
            args[0] = "\(configProxy.dvisvgmPath?.path ?? "dvisvgm")"
        return _original_run(args, *popenargs, **kwargs)
    
    subprocess.run = patched_run
    """
    
    let main = Python.import("__main__")
    Python.exec(code, main.__dict__)
    
    _manim = try Python.attemptImport("manim")
    defer { _manim = nil }
    
    _numpy = try Python.attemptImport("numpy")
    defer { _numpy = nil }
    
    
    let config = manim.config
    config["background_color"] = configProxy.backgroundColor.pythonObject
    config["background_opacity"] = configProxy.backgroundColor.alpha.pythonObject
    
    config["media_dir"] = configProxy.mediaDirectory.path.pythonObject
    config["save_sections"] = configProxy.saveSections.pythonObject
    config["output_file"] = "\(configProxy.mediaDirectory)/\(configProxy.fileName)".pythonObject
    config["movie_file_extension"] = ("." + configProxy.format.rawValue).pythonObject
    config["format"] = configProxy.format.rawValue.pythonObject
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
    config["verbosity"] = configProxy.verbosity.rawValue.uppercased().pythonObject
    
    // MARK: - Tweak Logging
    
    let emit = PythonFunction { args in
        let record = args[0].format(args[1])
        let logger = Logger(subsystem: "Swift-Manim", category: "Manim Logs")
        logger.info("\(record.description.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines.union(["\""])))")
        return Python.None
    }
    
    let types = Python.import("types")
    for handler in manim.logger.handlers {
        if Bool(Python.hasattr(handler, "console"))! {
            handler.emit = types.MethodType(emit, handler)
        }
    }
    
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
