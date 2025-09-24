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
        Array(self.pythonObject.get_brackets())!
    }
    
    public var rows: Array<Group> {
        Array(self.pythonObject.get_rows())!
    }
    
    public var columns: Array<Group> {
        Array(self.pythonObject.get_columns())!
    }
    
    /// The entries of the matrix, in row-major order.
    public var entries: Array<Group> {
        Array(self.pythonObject.get_entries())!
    }
    
    public init(_ lists: [[some PythonConvertible]], leftBracket: String = "[", rightBracket: String = "]") {
        super.init(manim.Matrix(lists, left_bracket: leftBracket, right_bracket: rightBracket))
    }
    
    public required init(_ pythonObject: PythonObject) { super.init(pythonObject) }
    
}
