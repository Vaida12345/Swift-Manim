//
//  TracedPath.swift
//  Manim
//
//  Created by Vaida on 2025-09-25.
//

import OSLog
import Foundation
import PythonKit


/// Traces the path of a point returned by a function call.
///
/// You can create this object directly, or use ``MObject/trace(_:color:width:dissipatingTime:)``.
///
/// ![Preview](trace)
///
/// ```swift
/// let dot = Dot(at: [2, 0])
/// let trace = dot.trace(\.center, dissipatingTime: 0.5)
/// scene.add(dot, trace)
///
/// withAnimation {
///     dot.shift(by: [-2, 0])
///         .path(.arc(.degrees(45)))
/// }
/// ```
public final class TracedPath: VMObject {
    
    /// Traces the path of a point returned by a function call.
    ///
    /// - Parameters:
    ///   - callable: The function to be traced.
    ///   - color: The color of the trace.
    ///   - width: The width of the trace.
    ///   - opacity: The initial opacity.
    ///   - dissipatingTime: The time taken for the path to dissipate. Default set to `nil` which disables dissipation.
    ///
    /// - bug: You may want to disable cashing when using `trace` with `wait`.
    ///
    /// - SeeAlso: ``MObject/trace(_:color:width:dissipatingTime:)``
    public init(_ callable: @autoclosure @escaping () -> Point, color: Color = .yellow, width: Double = 2, opacity: Double = 1, dissipatingTime: Double? = nil) {
        super.init(_pythonObject: manim.VMobject())
        
        func addLine(from: Point, to: Point) {
            let line = Line(from: from, to: to, width: width, color: color)
            line.set(opacity: opacity)
            self.add(line)
            if let dissipatingTime {
                let opacityDelta = 1 / (dissipatingTime * Double(scene.renderer.camera.frame_rate)!)
                
                line.addUpdater {
                    line.set(opacity: line.strokeColor.alpha - opacityDelta)
                    if line.strokeColor.alpha <= 0 {
                        line.removeAllUpdaters()
                    }
                }
            }
        }
        
        let initialPoint = callable()
        addLine(from: initialPoint, to: initialPoint)
        
        self.addUpdater {
            addLine(from: self.children.last!.as(Line.self).end, to: callable())
            
            if dissipatingTime != nil {
                for child in self.children {
                    let line = child.as(Line.self)
                    if line.strokeColor.alpha <= 0 {
                        self.remove(child)
                    }
                }
            }
        }
    }
    
    @_disfavoredOverload
    required init(_pythonObject: PythonObject) { super.init(_pythonObject: _pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, defaultColor: Color = .white, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, defaultColor: defaultColor, builder)
    }
    
}


extension MObject {
    
    /// Traces the path of a point returned by a function call.
    ///
    /// ![Preview](trace)
    ///
    /// ```swift
    /// let dot = Dot(at: [2, 0])
    /// let trace = dot.trace(\.center, dissipatingTime: 0.5)
    /// scene.add(dot, trace)
    ///
    /// withAnimation {
    ///     dot.shift(by: [-2, 0])
    ///         .path(.arc(.degrees(45)))
    /// }
    /// ```
    ///
    /// - bug: You may want to disable cashing when using `trace` with `wait`.
    ///
    /// - Parameters:
    ///   - keyPath: The property to be traced.
    ///   - color: The color of the trace.
    ///   - width: The width of the trace.
    ///   - dissipatingTime: The time taken for the path to dissipate. Default set to `nil` which disables dissipation.
    public func trace(_ keyPath: KeyPath<MObject, Point>, color: Color? = nil, width: Double = 2, dissipatingTime: Double? = nil) -> TracedPath {
        TracedPath(self[keyPath: keyPath], color: color ?? self.color, width: width, opacity: self.color.alpha, dissipatingTime: dissipatingTime)
    }
    
}
