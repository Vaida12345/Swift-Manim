//
//  Camera.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/12.
//

import PythonKit


/// The camera of the scene.
///
/// You don't create an instance yourself, you retrieve ``SceneProxy/camera`` from ``SceneProxy``.
///
/// You can use the suite that comes with ``Transformable`` to move the camera.
///
/// ```swift
/// withAnimation {
///     scene.camera.move(to: [1, 1])
/// }
/// ```
public final class MovingCamera: Transformable {
    
    var pythonObject: PythonObject
    
    public var _pythonObject: PythonObject {
        pythonObject.frame
    }
    
    init(_ pythonObject: PythonObject) {
        self.pythonObject = pythonObject
    }
    
}
