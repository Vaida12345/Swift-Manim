//
//  MObject.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/7.
//

import MacroCollection
import SwiftUI
import PythonKit


/// Mathematical Object: base class for objects that can be displayed on screen.
@MainActor
public class MObject: @MainActor PythonConvertible, @MainActor CustomStringConvertible, @MainActor ConvertibleFromPython, @MainActor Transformable {
    
    public var pythonObject: PythonKit.PythonObject
    
    public var description: String {
        "\(type(of: self as Any))(\(self.pythonObject))"
    }
    
    public var _transformable: PythonObject {
        self.pythonObject
    }
    
    /// Creates an instance with the initializer.
    required public init(_ pythonObject: PythonObject) {
        self.pythonObject = pythonObject
    }
    
    
    /// Set the fill color and fill opacity.
    ///
    /// - Parameters:
    ///   - color: Fill color.
    ///   - opacity: Fill opacity.
    @discardableResult
    public func fill(_ color: Color, opacity: Double = 1) -> AttachedAnimation {
        AttachedAnimation(base: self, closure: Closure("set_fill", [("color", color), ("opacity", opacity)]))
    }
    
    /// Set the color and opacity.
    @discardableResult
    public func set(color: Color) -> AttachedAnimation {
        AttachedAnimation(base: self, closure: Closure("set_color", [("color", color)]))
    }
    
    /// Add `child` as sub object.
    public func add(_ child: MObject) {
        self.pythonObject.add(child)
    }
    
    /// Remove `child` as sub object.
    ///
    /// - Note: This has no effect if `child` is not a children of `self`.
    public func remove(_ child: MObject) {
        self.pythonObject.remove(child)
    }
    
    /// Set the stroke color and stroke opacity.
    ///
    /// - Parameters:
    ///   - color: stroke color.
    ///   - width: stroke color width.
    ///   - opacity: stroke opacity.
    @discardableResult
    public func stroke(_ color: Color, width: Double = 2, opacity: Double = 1) -> AttachedAnimation {
        AttachedAnimation(base: self, closure: Closure("set_stroke", [("color", color), ("opacity", opacity), ("width", width)]))
    }
    
    /// Add an update function to this object.
    ///
    /// - Parameters:
    ///   - index: The index at which the new updater should be added.
    ///   - initialCall: Whether or not to call the updater initially.
    ///   - handler: The update handler.
    ///
    /// - Experiment: You must update `self` in `handler`.
    public func addUpdater(index: Int? = nil, initialCall: Bool = false, handler: @escaping () -> Void) {
        let uniqueName = "helper_\(UUID().uuidString.replacingOccurrences(of: "-", with: "_"))"
        let bridgeName = "_swift_bridge_\(UUID().uuidString.replacingOccurrences(of: "-", with: "_"))"
        
        let code = """
        def \(uniqueName)(obj):
            \(bridgeName)(obj)
        """
        
        let main = Python.import("__main__")
        main.__dict__[bridgeName] = PythonObject(PythonFunction({ object in
            handler()
            return Python.None
        }))
        Python.exec(code, main.__dict__)
        self.pythonObject.add_updater(main.__dict__[uniqueName], index: index, call_updater: initialCall)
    }
    
    /// Edit points, colors and sub objects to be identical to another ``MObject``.
    ///
    /// - Parameters:
    ///   - target: The target object
    ///   - matchHeight: If `true`, then the transformed object will match the height of the original
    ///   - matchWidth: If `true`, then the transformed object will match the width of the original
    ///   - matchDepth: If `true`, then the transformed object will match the depth of the original
    ///   - matchCenter: If `true`, then the transformed object will match the center of the original
    ///   - stretch: If `true`, then the transformed object will stretch to fit the proportions of the original
    @discardableResult
    public func become(_ target: MObject, matchHeight: Bool = false, matchWidth: Bool = false, matchDepth: Bool = false, matchCenter: Bool = false, stretch: Bool = false) -> AttachedAnimation {
        var closure = Closure("become")
        closure.append("", target)
        closure.append("match_height", matchHeight)
        closure.append("match_width",  matchWidth)
        closure.append("match_depth",  matchDepth)
        closure.append("match_center", matchCenter)
        closure.append("stretch",      stretch)
        
        return AttachedAnimation(base: self, closure: closure)
    }
    
    /// Create and return an identical copy of the object including all children.
    public func copied() -> Self {
        Self(self.pythonObject.copy())
    }
    
}
