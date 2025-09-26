//
//  CapStyle.swift
//  Manim
//
//  Created by Vaida on 2025-09-25.
//

import PythonKit


extension VMObject {
    
    /// A style that determines how the ends of lines are rendered when drawing stroked paths.
    ///
    /// See the example below for a visual illustration of the different cap styles.
    ///
    /// ![Preview](capStyle)
    ///
    /// ```swift
    /// let arcs = CapStyle.allCases.map { style in
    ///     let arc = Arc(radius: 1, startAngle: .degrees(0), angle: .degrees(90), color: .green)
    ///     arc.strokeWidth = 20
    ///     arc.capStyle = style
    ///     return arc
    /// }
    /// scene.arrange(arcs, direction: .right, spacing: 1)
    /// scene.add(arcs)
    ///
    /// for arc in arcs {
    ///     let label = Text(arc.capStyle.description, fontSize: 24)
    ///     label.move(below: arc)
    ///     scene.add(label)
    /// }
    /// ```
    @MainActor
    public enum CapStyle: @MainActor PythonConvertible, @MainActor ConvertibleFromPython, CaseIterable, @MainActor CustomStringConvertible {
        case auto, round, butt, square
        
        public var description: String {
            switch self {
            case .auto: ".auto"
            case .round: ".round"
            case .butt: ".butt"
            case .square: ".square"
            }
        }
        
        public var pythonObject: PythonObject {
            switch self {
            case .auto:
                manim.CapStyleType.AUTO
            case .round:
                manim.CapStyleType.ROUND
            case .butt:
                manim.CapStyleType.BUTT
            case .square:
                manim.CapStyleType.SQUARE
            }
        }
        
        public init?(_ object: PythonObject) {
            switch object {
            case manim.CapStyleType.AUTO:
                self = .auto
            case manim.CapStyleType.ROUND:
                self = .round
            case manim.CapStyleType.BUTT:
                self = .butt
            case manim.CapStyleType.SQUARE:
                self = .square
            default:
                return nil
            }
        }
    }

    
}
