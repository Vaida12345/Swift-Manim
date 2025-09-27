//
//  Transform 2.swift
//  Manim
//
//  Created by Vaida on 2025-09-27.
//

import PythonKit


extension Transform {
    
    /// Defines the transform styles that can be used in ``MObject/transform(to:style:)``.
    ///
    /// You can use the ``MObject/transform(to:transform:)`` to create a transform.
    ///
    /// - ``Style/matchShapes``
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Transform_matchShapes.mov)
    ///
    /// - ``Style/matchTex``
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Transform_matchTex.mov)
    ///
    /// - ``Style/cyclicReplace``
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Transform_cyclicReplace.mov)
    ///
    /// - ``Style/plain``
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Transform_plain.mov)
    ///
    /// - ``Style/fade``
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Transform_fade.mov)
    ///
    /// - ``Style/replace``
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Transform_replace.mov)
    ///
    /// - ``Style/swap``
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Transform_swap.mov)
    @MainActor
    public enum Style: @MainActor PythonConvertible {
        
        /// An animation trying to transform groups by matching the shape of their sub-objects.
        ///
        /// This method is similar to Magic Move, match characters.
        ///
        /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Transform_matchShapes.mov)
        ///
        /// ```swift
        /// withAnimation {
        ///     Text("the morse code")
        ///         .transform(to: Text("here come dots"), style: .matchShapes)
        /// }
        /// ```
        case matchShapes
        
        /// A transformation trying to transform rendered LaTeX strings.
        ///
        /// Two sub-objects match if their components matches.
        ///
        /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Transform_matchTex.mov)
        ///
        /// ```swift
        /// let dest = MathTex("3", "^2", "+", "4", "^2", "=", "5", "^2")
        /// dest.move(to: [0, -1])
        ///
        /// withAnimation {
        ///     MathTex("a", "^2", "+", "b", "^2", "=", "c", "^2")
        ///         .transform(to: dest, style: .matchTex)
        /// }
        /// ```
        case matchTex
        
        /// An animation moving mobjects cyclically.
        ///
        /// In particular, this means: the first mobject takes the place of the second mobject, the second one takes the place of the third mobject, and so on. The last mobject takes the place of the first one.
        ///
        /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Transform_cyclicReplace.mov)
        ///
        /// ```swift
        /// let dot = Dot(at: [-2, 0])
        /// let dest = Dot(at: [2, 0])
        /// scene.add(dest, dot)
        ///
        /// withAnimation {
        ///     dot.transform(to: dest, style: .cyclicReplace)
        ///         .path(.arc(angle: .degrees(120)))
        /// }
        /// ```
        case cyclicReplace
        
        /// A Transform transforms a Mobject into a target Mobject.
        ///
        /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Transform_plain.mov)
        ///
        /// ```swift
        /// let dot = Dot(at: [-2, 0])
        /// let dest = Dot(at: [2, 0])
        /// scene.add(dest, dot)
        ///
        /// withAnimation {
        ///     dot.transform(to: dest)
        /// }
        /// ```
        case plain
        
        /// Fades one mobject into another.
        ///
        /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Transform_fade.mov)
        ///
        /// ```swift
        /// let rect = Rectangle(width: 4, height: 2)
        /// rect.shift(by: [-2, 0])
        /// let dest = Dot(at: [2, 0])
        /// scene.add(dest, rect)
        ///
        /// withAnimation {
        ///     rect.transform(to: dest, style: .fade)
        /// }
        /// ```
        case fade
        
        /// Fades `children` of one mobject into `children` of another one.
        ///
        /// - Bug: Does not work
        case fadeChildren
        
        /// Replaces and morphs a mobject into a target mobject.
        ///
        /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Transform_replace.mov)
        ///
        /// ```swift
        ///  let rect = Rectangle(width: 4, height: 2)
        /// rect.shift(by: [-2, 0])
        /// let dest = Dot(at: [2, 0])
        ///
        /// withAnimation {
        ///     rect.transform(to: dest, style: .replace)
        /// }
        /// ```
        case replace
        
        /// Swaps two objects
        ///
        /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/Transform_swap.mov)
        ///
        /// ```swift
        ///  let rect = Rectangle(width: 4, height: 2)
        /// rect.shift(by: [-2, 0])
        /// let dest = Dot(at: [2, 0])
        ///
        /// withAnimation {
        ///     rect.transform(to: dest, style: .swap)
        /// }
        /// ```
        case swap
        
        public var pythonObject: PythonObject {
            switch self {
            case .matchShapes: manim.TransformMatchingShapes
            case .matchTex: manim.TransformMatchingTex
            case .cyclicReplace: manim.CyclicReplace
            case .plain: manim.Transform
            case .fade: manim.FadeTransform
            case .fadeChildren: manim.FadeTransformPieces
            case .replace: manim.ReplacementTransform
            case .swap: manim.Swap
            }
        }
    }

    
}
