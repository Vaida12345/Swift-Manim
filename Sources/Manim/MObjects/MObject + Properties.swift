//
//  MObject + Properties.swift
//  Manim
//
//  Created by Vaida on 2025-09-20.
//


extension MObject {
    
    // MARK: - read write
    private var _color: ReadWriteProperty<Color> {
        ReadWriteProperty(origin: self, read: Closure("get_color", []), write: "set_color")
    }
    /// The primary color of the object.
    public var color: ReadWriteProperty<Color> {
        get { _color }
        set { _color.update(to: newValue) }
    }
    
    private var _x: ReadWriteProperty<Double> {
        ReadWriteProperty(origin: self, read: Closure("get_x", []), write: "set_x")
    }
    /// The `x`-coordinate
    public var x: ReadWriteProperty<Double> {
        get { _x }
        set { _x.update(to: newValue) }
    }
    
    private var _y: ReadWriteProperty<Double> {
        ReadWriteProperty(origin: self, read: Closure("get_y", []), write: "set_y")
    }
    /// The `y`-coordinate
    public var y: ReadWriteProperty<Double> {
        get { _y }
        set { _y.update(to: newValue) }
    }
    
    // MARK: - write only
    /// Write-only property for setting zIndex.
    public var zIndex: Int {
        get { fatalError("Does not support GET") }
        set { self.call("set_z_index", arguments: [(nil, newValue.description)]) }
    }
    
    // MARK: - read only
    /// The bottom point.
    public var bottom: ReadableProperty<Point> {
        ReadableProperty(origin: self, read: Closure("get_bottom", []))
    }
    
    /// The top point.
    public var top: ReadableProperty<Point> {
        ReadableProperty(origin: self, read: Closure("get_top", []))
    }
    
    /// The left point.
    public var left: ReadableProperty<Point> {
        ReadableProperty(origin: self, read: Closure("get_left", []))
    }
    
    /// The right point.
    public var right: ReadableProperty<Point> {
        ReadableProperty(origin: self, read: Closure("get_right", []))
    }
    
    /// The starting point.
    public var origin: ReadableProperty<Point> {
        ReadableProperty(origin: self, read: Closure("get_start", []))
    }
    
    /// The center point.
    public var center: ReadableProperty<Point> {
        ReadableProperty(origin: self, read: Closure("get_center", []))
    }
    
    /// Returns the point, where the stroke that surrounds the object ends.
    public var end: ReadableProperty<Point> {
        ReadableProperty(origin: self, read: Closure("get_end", []))
    }
    
    /// Returns the point, where the stroke that surrounds the object starts.
    public var start: ReadableProperty<Point> {
        ReadableProperty(origin: self, read: Closure("get_start", []))
    }
    
}
