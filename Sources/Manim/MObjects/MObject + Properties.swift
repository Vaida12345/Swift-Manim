//
//  MObject + Properties.swift
//  Manim
//
//  Created by Vaida on 2025-09-20.
//


extension MObject {
    
    // MARK: - read write
    /// The `x`-coordinate
    public var x: Double {
        get { Double(self.pythonObject.get_x())! }
        set { self.pythonObject.set_x(newValue) }
    }
    
    /// The `y`-coordinate
    public var y: Double {
        get { Double(self.pythonObject.get_y())! }
        set { self.pythonObject.set_y(newValue) }
    }

    // MARK: - write only
    /// Write-only property for setting zIndex.
    public var zIndex: Double {
        get { fatalError("Does not support GET") }
        set { self.pythonObject.set_z_index(newValue) }
    }
    
    // MARK: - read only
    /// The bottom point.
    public var bottom: Point {
        Point(self.pythonObject.get_bottom())!
    }
    
    /// The top point.
    public var top: Point {
        Point(self.pythonObject.get_top())!
    }
    
    /// The left point.
    public var left: Point {
        Point(self.pythonObject.get_left())!
    }
    
    /// The right point.
    public var right: Point{
        Point(self.pythonObject.get_right())!
    }
    
    /// The origin, defined as the center point.
    public var origin: Point {
        get { self.center }
        set { self.center = newValue }
    }
    
    /// The center point.
    public var center: Point {
        get { Point(self.pythonObject.get_center())! }
        set { self.move(to: newValue) }
    }
    
    /// Returns the point, where the stroke that surrounds the object ends.
    public var end: Point {
        Point(self.pythonObject.get_end())!
    }
    
    /// Returns the point, where the stroke that surrounds the object starts.
    public var start: Point {
        Point(self.pythonObject.get_start())!
    }
    
    public var width: Double {
        Double(self.pythonObject.width)!
    }
    
    public var height: Double {
        Double(self.pythonObject.height)!
    }
    
}
