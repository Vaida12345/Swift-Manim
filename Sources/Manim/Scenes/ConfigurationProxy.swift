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
    public var pythonLibraryPath: FinderItem? = "/opt/homebrew/Cellar/python@3.13/3.13.7/Frameworks/Python.framework/Versions/3.13/lib/libpython3.13.dylib"
    
    /// If specified, it will search python packages in the given path.
    ///
    /// To setup a `venv`, use
    /// ```sh
    /// /opt/homebrew/opt/python@3.13/bin/python3.13 -m venv ~/manim-venv
    /// source ~/manim-venv/bin/activate
    /// pip install manim numpy
    /// ```
    ///
    /// 
    ///
    /// - Experiment: It may take time to setup when calling it for the first time.
    public var pythonPackagesPath: FinderItem? = "\(NSHomeDirectory())/manim-venv/lib/python3.13/site-packages"
    
    public var latexPath: FinderItem? = "/Library/TeX/texbin/latex"
    public var dvisvgmPath: FinderItem? = "/Library/TeX/texbin/dvisvgm"
    
    /// Background color of the scene.
    public var backgroundColor: Color = .black
    
    /// A number between 0.0 (fully transparent) and 1.0 (fully opaque).
    public var backgroundOpacity: Double = 1
    
    /// The directory to place all medias.
    public var mediaDirectory: FinderItem = "\(NSHomeDirectory())/Documents/Swift Manim"
    
    /// Whether to save single videos for each section in addition to the movie file.
    public var saveSections: Bool = false
    
    /// The output filename
    public var fileName: String = "output"
    
    /// File format
    public var format: Format = .mp4
    
    /// Frame width and height in pixels.
    public var size: CGSize?
    
    /// Frame rate in frames per second.
    public var frameRate: Int?
    
    /// Frame width in *local* logical units.
    public var localWidth: Int?
    
    /// Whether to play the rendered movie on render completion.
    public var preview: Bool = true
    
    /// Whether to disable cache, for debugging purposes.
    public var disableCache: Bool = false
    
    /// Video quality.
    ///
    /// This value would only be effective if ``frameRate``, ``size`` is `nil`.
    public var quality: Quality? = .example
    
    /// The currently active renderer.
    public var renderer: Renderer = .Cairo
    
    
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
    
}
