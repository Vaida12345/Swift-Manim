//
//  TipableVMObject.swift
//  Manim
//
//  Created by Vaida on 2025-09-24.
//


/// A ``VMObject`` that can have tips.
///
/// You can use ``addTip(shape:at:)`` to add a new Tip.
///
/// ```swift
/// let line = Line(from: .center, to: [2, 2])
/// line.addTip(at: .start)
/// line.addTip(at: .end)
///
/// withAnimation(in: .parallel) {
///     line.show()
/// }
/// ```
///
/// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/add_tip.mov)
public class TipableVMObject: VMObject {
    
}


extension TipableVMObject {
    
    /// The length of the line.
    ///
    /// ```swift
    /// let line = Line(from: .center, to: [2, 2])
    /// line.length // 2.8284271247461903
    /// ```
    public var length: Double {
        Double(self.pythonObject.get_length())!
    }
    
    /// Returns a ``Group`` (collection of ``VMObject``s) containing the the instance’s tips.
    ///
    /// ```swift
    /// let line = Line(from: .center, to: [2, 2])
    /// line.addTip(at: .start)
    /// line.addTip(at: .end)
    /// line.tips // Group([MObject(ArrowTriangleFilledTip), MObject(ArrowTriangleFilledTip)])
    /// ```
    public var tips: Group {
        Group(self.pythonObject.get_tips())
    }
    
    /// Adds a tip to the instance.
    ///
    /// - Parameters:
    ///   - shape: The tip shape, `nil` for the default arrow shape.
    ///   - position: The position to add the tip. Note that if multiple shapes are added to the same position, they will be positioned in serial.
    ///
    /// - Returns: The Tip object.
    ///
    /// ```swift
    /// let line = Line(from: .center, to: [2, 2])
    /// line.addTip(at: .start)
    /// line.addTip(at: .end)
    ///
    /// withAnimation(in: .parallel) {
    ///     line.show()
    /// }
    /// ```
    ///
    /// ![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/add_tip.mov)
    @discardableResult
    public func addTip(shape: Arrow.TipShape = .triangleFilled, at position: Position) -> MObject {
        let tip = self.pythonObject.create_tip(tip_shape: shape, at_start: position == .start)
        self.pythonObject.add_tip(tip, at_start: position == .start)
        return MObject(tip)
    }
    
    
    /// A position on a line.
    public enum Position: Equatable {
        case start, end
    }
    
}
