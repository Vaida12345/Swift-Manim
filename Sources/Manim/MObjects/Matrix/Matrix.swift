//
//  Matrix.swift
//  Manim
//
//  Created by Vaida on 2025-09-23.
//

import PythonKit


public class Matrix: VMObject {
    
    /// The left and right brackets, packed in an array.
    public var brackets: Array<MObject> {
        self.pythonObject.get_brackets().map { MObject($0) }
    }
    
    public var rows: Array<Group> {
        self.pythonObject.get_rows().map { Group($0) }
    }
    
    public var columns: Array<Group> {
        self.pythonObject.get_columns().map { Group($0) }
    }
    
    /// The entries of the matrix, in row-major order.
    public var entries: Array<Group> {
        self.pythonObject.get_entries().map { Group($0) }
    }
    
    public init(_ lists: [[some PythonConvertible]], leftBracket: String = "[", rightBracket: String = "]") {
        super.init(manim.Matrix(lists, left_bracket: leftBracket, right_bracket: rightBracket))
    }
    
    @_disfavoredOverload
    required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
