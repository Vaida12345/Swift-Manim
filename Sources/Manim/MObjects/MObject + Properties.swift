//
//  MObject + Properties.swift
//  Manim
//
//  Created by Vaida on 2025-09-20.
//


extension MObject {
    
    // MARK: - read write
    /// The `x`-coordinate value of ``origin`` (ie, center).
    ///
    /// You can use this property to access and modify the x-coordinate value.
    ///
    /// ```swift
    /// let dot = Dot(at: [1, 2])
    /// let text = Text("(1, 2)")
    /// let numberLine = NumberPlane()
    ///
    /// text.move(below: dot)
    /// scene.add(numberLine, dot, text)
    /// dot.x // 1
    /// ```
    ///
    /// ![Preview](coord)
    public var x: Double {
        get { Double(self.pythonObject.get_x())! }
        set { self.pythonObject.set_x(newValue) }
    }
    
    /// The `y`-coordinate value of ``origin`` (ie, center).
    ///
    /// You can use this property to access and modify the y-coordinate value.
    ///
    /// ```swift
    /// let dot = Dot(at: [1, 2])
    /// let text = Text("(1, 2)")
    /// let numberLine = NumberPlane()
    ///
    /// text.move(below: dot)
    /// scene.add(numberLine, dot, text)
    /// dot.y // 2
    /// ```
    ///
    /// ![Preview](coord)
    public var y: Double {
        get { Double(self.pythonObject.get_y())! }
        set { self.pythonObject.set_y(newValue) }
    }

    /// The z index for controlling layer.
    ///
    ///
    /// ```swift
    /// let rect1 = Square(length: 4, fill: .blue)
    /// let rect2 = Square(length: 4, fill: .green)
    /// let rect3 = Square(length: 4, fill: .red)
    ///
    /// rect1.move(to: [-2, 2])
    /// rect2.move(to: [-1, 1])
    /// rect3.move(to: [0, 0])
    ///
    /// rect2.zIndex = 999
    ///
    /// scene.add(rect1, rect2, rect3)
    /// ```
    ///
    /// ![Preview](zIndex)
    public var zIndex: Double {
        get { Double(self.pythonObject.z_index)! }
        set { self.pythonObject.z_index = newValue.pythonObject }
    }
    
    /// Sets both the ``VMObject/fillColor`` and ``VMObject/strokeColor``.
    ///
    /// If `fillColor` is not `nil`, returns `fillColor`. Otherwise `strokeColor`.
    ///
    /// ```swift
    /// let dot = Dot()
    /// dot.color = .red
    /// scene.add(dot)
    /// ```
    ///
    /// ![Preview](dot)
    public var color: Color {
        get { Color(self.pythonObject.color)! }
        set { self.pythonObject.color = newValue.pythonObject }
    }
    
    /// The origin, defined as the center point.
    ///
    /// ![Preview](origin)
    public var origin: Point {
        get { self.center }
        set { self.center = newValue }
    }
    
    /// The center point.
    ///
    /// ![Preview](origin)
    public var center: Point {
        get { Point(self.pythonObject.get_center())! }
        set { self.move(to: newValue) }
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
    
    /// Returns the point, where the stroke that surrounds the object ends.
    public var end: Point {
        Point(self.pythonObject.get_end())!
    }
    
    /// Returns the point, where the stroke that surrounds the object starts.
    public var start: Point {
        Point(self.pythonObject.get_start())!
    }
    
    /// The width of the object.
    ///
    /// ```swift
    /// let rect = Rectangle(width: 4, height: 2)
    /// rect.width // 4.0
    /// ```
    public var width: Double {
        Double(self.pythonObject.width)!
    }
    
    /// The height of the object.
    ///
    /// ```swift
    /// let rect = Rectangle(width: 4, height: 2)
    /// rect.height // 2.0
    /// ```
    public var height: Double {
        Double(self.pythonObject.height)!
    }
    
}
