//
//  Generator.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import Cocoa
import FinderItem
import OSLog


public final class Generator {
    
    private var components: [String]
    
    private let logger = Logger(subsystem: "Generator", category: "add(_:ignoresIndentGuide:)")
    
    
    public static let main = Generator()
    
    
    /// The indentation would be added automatically according to `indentCount`, unless `ignoresIndentGuide`.
    internal func add(_ component: String, ignoresIndentGuide: Bool = false, file: String = #file, line: UInt = #line, function: StaticString = #function) {
        self.components.append((ignoresIndentGuide ? "" : [String](repeating: "    ", count: indentCount).joined())+component)
        logger.info("Insert line from \(function) \(file):\(line):\n'\(component)'")
    }
    
    internal func addConfiguration(name: String, value: String) {
        self.add("config.\(name) = \(value)", ignoresIndentGuide: true)
    }
    
    public func generate<S>(_ sceneType: S.Type = S.self, to folder: FinderItem = "\(NSHomeDirectory())/Documents/Swift Manim") throws where S: Scene {
        let scene = S()
        scene.body()
        
        self.add("", ignoresIndentGuide: true)
        self.add("", ignoresIndentGuide: true)
        
        var configuration = scene.config
        scene.configure(&configuration)
        configuration.push()
        
        // remove any previous output files
        for child in try scene.config.mediaFolder.children(range: .contentsOfDirectory) where child.name.hasPrefix(configuration.destination.stem) {
            try child.remove()
        }
        
        try folder.makeDirectory()
        try self.components.joined(separator: "\n").write(toFile: "\(folder)/swiftmanim.py", atomically: true, encoding: .utf8)
        
        let command = "manim \"\(folder)/swiftmanim.py\""
        let destination = "\(folder)/run.command"
        try command.write(toFile: destination, atomically: true, encoding: .utf8)
        
        let manager = ShellManager()
        manager.run(arguments: "open \"\(destination)\"") // must use user shell to load PATH
        manager.wait()
    }
    
    internal func assign<T, Parent>(type: T.Type, by parent: Parent, calling method: String, args: Closure.Arguments) -> T where Parent: PyObject, T: PyObject {
        let result = T(identifier: __formVariableName(base: "\(T.self)"))
        self.add("\(result.identifier) = \(parent.identifier).\(method)\(args.representation)")
        return result
    }
    
    internal func assign<T>(_ method: ReadableProperty<T>) -> T where T: PyObject {
        self.assign(type: T.self, by: method.origin, calling: method.read.name, args: method.read.arguments)
    }
    
    
    private init() {
        self.components = ["from manim import *", "from numpy import *", ""]
    }
    
    
    public struct Configuration {
        
        /// Configures the background properties
        public var background: Background?
        
        /// The output file
        public var destination: FinderItem = "\(NSHomeDirectory())/Documents/Swift Manim/output"
        
        /// Main output directory.
        public var mediaFolder: FinderItem = "\(NSHomeDirectory())/Documents/Swift Manim"
        
        /// Enable GUI interaction.
        public var enableGUI: Bool?
        
        /// File format
        public var format: Format = .mp4
        
        /// Frame rate in frames per second.
        public var frameRate: Int?
        
        /// Frame width in *local* logical units.
        public var localWidth: Int?
        
        /// Frame width and height in pixels.
        public var size: CGSize?
        
        /// Whether to play the rendered movie.
        var preview: Bool = true
        
        /// Video quality.
        ///
        /// This value would only be effective if ``frameRate``, ``size`` is `nil`.
        public var quality: Quality? = .example
        
        /// The currently active renderer.
        public var renderer: Renderer?
        
        /// Whether to save all frames in the scene as images files.
        public var renderAllImages: Bool?
        
        public var imagesDestination: FinderItem = "\(NSHomeDirectory())/Documents/Swift Manim/Image Sequence"
        
        /// Push the configs to the main generator.
        func push() {
            Generator.main.add("# Manim Configurations", ignoresIndentGuide: true)
            if let background {
                if let color = background.color {
                    Generator.main.addConfiguration(name: "background_color", value: color.representation)
                }
                if let opacity = background.opacity {
                    Generator.main.addConfiguration(name: "background_opacity", value: opacity.description)
                }
            }
            Generator.main.addConfiguration(name: "output_file", value: "\"\(destination)\"")
            Generator.main.addConfiguration(name: "media_dir", value: "\"\(mediaFolder)\"")
            
            if let enableGUI {
                Generator.main.addConfiguration(name: "enable_gui", value: enableGUI.representation)
            }
            Generator.main.addConfiguration(name: "format", value: format.representation)
            Generator.main.addConfiguration(name: "movie_file_extension", value: "\".\(format.rawValue)\"")
            
            if let frameRate {
                Generator.main.addConfiguration(name: "frame_rate", value: frameRate.description)
            }
            if let localWidth {
                Generator.main.addConfiguration(name: "frame_width",  value: localWidth.description)
            }
            if let size {
                Generator.main.addConfiguration(name: "pixel_height", value: Int(size.height).description)
                Generator.main.addConfiguration(name: "pixel_width",  value: Int(size.width).description)
            }
            if frameRate == nil && size == nil, let quality {
                Generator.main.addConfiguration(name: "quality",  value: "\"\(quality.rawValue)\"")
            }
            if let renderer {
                Generator.main.addConfiguration(name: "renderer",  value: "\"\(renderer.rawValue)\"")
            }
            if let renderAllImages {
                Generator.main.addConfiguration(name: "save_pngs",  value: renderAllImages.representation)
            }
            Generator.main.addConfiguration(name: "images_dir",  value: "\"\(imagesDestination)\"")
            
            Generator.main.addConfiguration(name: "preview", value: preview.representation)
        }
        
        
        public enum Quality: String {
            case example = "example_quality"
            case low = "low_quality"
            case medium = "medium_quality"
            case high = "high_quality"
            case production = "production_quality"
            case best = "fourk_quality"
        }
        
        public enum Renderer: String {
            case Cairo = "cairo"
            case OpenGL = "opengl"
        }
        
        public struct Background {
            
            /// Background color of the scene
            public var color: Color?
            
            /// A number between 0.0 (fully transparent) and 1.0 (fully opaque).
            public var opacity: Double?
        }
        
        public enum Format: String, PythonScriptConvertible {
            case png, gif, mp4, webm, mov
            
            public var representation: String {
                "\"\(self.rawValue)\""
            }
        }
        
    }
    
}
