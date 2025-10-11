//
//  ConfigurationProxy.swift
//  Manim
//
//  Created by Vaida on 2025-09-24.
//

import FinderItem
import Foundation


/// Render Configuration.
///
/// You can use ``withManim(scene:configuration:)`` to set configuration.
///
/// ```swift
/// try await withManim {
///     ...
/// } configuration {
///     $0.quality = .high
/// }
@MainActor
public final class ConfigurationProxy {
    
    /// If specified, uses the python `dylib` indicated by the path.
    ///
    /// [Read more](<doc:Setup>) about setting up the environment.
    public var pythonLibraryPath: FinderItem?
    
    /// If specified, it will search python packages in the given path.
    ///
    /// [Read more](<doc:Setup>) about setting up the environment.
    ///
    /// - Experiment: It may take time to setup when calling it for the first time.
    public var pythonPackagesPath: FinderItem? = "\(NSHomeDirectory())/Documents/Swift Manim/manim-venv/lib/python3.13/site-packages"
    
    /// If specified, use the `latex` compiler indicated by the path.
    ///
    /// [Read more](<doc:Setup>) about setting up the environment.
    public var latexPath: FinderItem? = "/Library/TeX/texbin/latex"
    
    /// If specified, use the `dvisvgm` compiler indicated by the path.
    ///
    /// [Read more](<doc:Setup>) about setting up the environment.
    public var dvisvgmPath: FinderItem? = "/Library/TeX/texbin/dvisvgm"
    
    /// Background color of the scene.
    public var backgroundColor: Color = .black
    
    /// The directory to place all medias.
    public var mediaDirectory: FinderItem = "\(NSHomeDirectory())/Documents/Swift Manim"
    
    /// Whether to save single videos for each section in addition to the movie file.
    public var saveSections: Bool = false
    
    /// The output filename
    public var fileName: String = "output"
    
    /// File format
    public var format: Format = .mov
    
    /// Frame width and height in pixels.
    public var size: CGSize?
    
    /// Frame rate in frames per second.
    public var frameRate: Int?
    
    /// Frame width in *local* logical units.
    public var localWidth: Int?
    
    /// Whether to play the rendered movie on render completion.
    public var preview: Bool = true
    
    /// Whether to disable cache, for debugging purposes.
    ///
    /// `Manim` comes with cache by default, and this could be troubling during debugging. For example, `print`s won't work as expected in ``MObject/addUpdater(index:initial:handler:)-(_,_,()->Void)``.
    public var disableCache: Bool = false
    
    /// Video quality.
    ///
    /// This value would only be effective if ``frameRate``, ``size`` is `nil`.
    public var quality: Quality? = .example
    
    /// The currently active renderer.
    public var renderer: Renderer = .Cairo
    
    /// Logger verbosity
    public var verbosity: Verbosity = .info
    
    
    /// Video Format
    public enum Format: String {
        case png, gif, mp4, webm, mov
    }
    
    public enum Quality: String {
        case example = "example_quality"
        case low = "low_quality"
        case medium = "medium_quality"
        
        /// 1080p @60fps
        case high = "high_quality"
        
        /// 1440p @60fps
        case production = "production_quality"
        
        /// 4k @60fps
        case best = "fourk_quality"
    }
    
    public enum Renderer: String {
        case Cairo = "cairo"
        case OpenGL = "opengl"
    }
    
    public enum Verbosity: String {
        case debug, info, warning, error, critical
    }
    
}
