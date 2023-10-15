//
//  Camera.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/12.
//

import Foundation


/// The camera of the scene.
public class Camera: MObject {
    
    public override func addUpdater(index: Int? = nil, initialCall: Bool = false, handler: (MObject) -> Void) {
        let object = MObject(identifier: __formVariableName(base: "\(MObject.self)"))
        let functionName = __formVariableName(base: "updater\(Self.self)")
        Generator.main.add("def \(functionName)(\(object.identifier)):")
        indentCount += 1
        handler(object)
        indentCount -= 1
        Generator.main.add("")
        self.attribute("frame.add_updater", to: [("update_function", functionName),
                                           ("index", index?.description),
                                           ("call_updater", initialCall.pyDescription)])
    }
    
    
    required init(identifier: String) {
        fatalError()
    }
    
    init() {
        super.init(identifier: "self.camera")
    }
    
}
