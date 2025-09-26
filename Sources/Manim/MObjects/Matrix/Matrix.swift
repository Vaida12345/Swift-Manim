//
//  Matrix.swift
//  Manim
//
//  Created by Vaida on 2025-09-23.
//

import PythonKit


/// A Matrix
///
/// ```swift
/// let matrix = Matrix([[1, 2], [3, 4]])
/// ```
///
/// ![Preview](Matrix)
public class Matrix: VMObject {
    
    /// The left and right brackets, packed in an array.
    public var brackets: Array<MObject> {
        self.pythonObject.get_brackets().map { MObject($0) }
    }
    
    /// Return rows of the matrix.
    public var rows: Array<Group> {
        self.pythonObject.get_rows().map { Group($0) }
    }
    
    /// Return columns of the matrix.
    public var columns: Array<Group> {
        self.pythonObject.get_columns().map { Group($0) }
    }
    
    /// The entries of the matrix, in row-major order.
    public var entries: Array<Group> {
        self.pythonObject.get_entries().map { Group($0) }
    }
    
    /// Creates a matrix.
    public init(_ lists: [[some PythonConvertible]], leftBracket: String = "[", rightBracket: String = "]") {
        super.init(manim.Matrix(lists, left_bracket: leftBracket, right_bracket: rightBracket))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
    @_disfavoredOverload
    required init(_ name: String, stroke: Color?, strokeWidth: Double?, fill: Color?, _ builder: (inout Closure.Arguments) -> Void) {
        super.init(name, stroke: stroke, strokeWidth: strokeWidth, fill: fill, builder)
    }
    
}
