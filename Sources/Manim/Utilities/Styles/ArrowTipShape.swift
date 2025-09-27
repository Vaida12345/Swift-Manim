//
//  ArrowTipShape.swift
//  Manim
//
//  Created by Vaida on 2025-09-24.
//

import PythonKit

extension Arrow {
    
    /// An enumeration of the available tip shapes for an `Arrow` in Manim.
    ///
    /// Use the ``filled`` property to get the filled version of an outline shape.
    ///
    /// ![Preview](Arrow_TipShape)
    ///
    /// ```swift
    /// let styles: [Arrow.TipShape] = [.circle, .diamond, .triangle]
    /// let arrows = styles.flatMap { style in
    ///     [(Arrow(from: [-2, 0], to: [1, 0], tip: style), style), (Arrow(from: [-2, 0], to: [1, 0], tip: style.filled), style.filled)]
    /// }
    /// scene.add(VStack(arrows.map(\.0)))
    /// for (arrow, style) in arrows {
    ///     let text = Text(style.description)
    ///     text.scale(0.5)
    ///     text.move(rightOf: arrow)
    ///     scene.add(text)
    /// }
    /// ```
    @MainActor
    public struct TipShape: @MainActor PythonConvertible, @MainActor CustomStringConvertible, @MainActor Equatable {
        
        let rawValue: UInt8
        
        public static let diamond = Arrow.TipShape(rawValue: 0)
        public static let circle = Arrow.TipShape(rawValue: 1)
        public static let triangle = Arrow.TipShape(rawValue: 2)
        
        static let _diamondFilled = Arrow.TipShape(rawValue: 3)
        static let _circleFilled = Arrow.TipShape(rawValue: 4)
        static let _triangleFilled = Arrow.TipShape(rawValue: 5)
        
        public var description: String {
            switch self {
            case TipShape.diamond: ".diamond"
            case TipShape.circle: ".circle"
            case TipShape.triangle: ".triangle"
            case TipShape._diamondFilled: ".diamond.filled"
            case TipShape._circleFilled: ".circle.filled"
            case TipShape._triangleFilled: ".triangle.filled"
            default: "some TipShape"
            }
        }
        
        public var pythonObject: PythonObject {
            switch self {
            case .diamond:
                manim.ArrowSquareTip
            case .circle:
                manim.ArrowCircleTip
            case .triangle:
                manim.ArrowTriangleTip
            case ._diamondFilled:
                manim.ArrowSquareFilledTip
            case ._circleFilled:
                manim.ArrowCircleFilledTip
            case ._triangleFilled:
                manim.ArrowTriangleFilledTip
            default:
                Python.None
            }
        }
        
        public var filled: TipShape {
            switch self {
            case .diamond: ._diamondFilled
            case .circle: ._circleFilled
            case .triangle: ._triangleFilled
            default: self
            }
        }
    }

    
}
