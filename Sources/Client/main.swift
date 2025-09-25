//
//  Source.swift
//  Manim
//
//  Created by Vaida on 8/8/24.
//

import Manim


try await withManim { scene in
    let matrix = Matrix([[1, 2, 3]])
    print(matrix.brackets)
    print(matrix.entries)
} configuration: {
    $0.quality = .medium
    $0.preview = false
}
