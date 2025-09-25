//
//  TipableVMObject.swift
//  Manim
//
//  Created by Vaida on 2025-09-24.
//


public class TipableVMObject: VMObject {
    
}


extension TipableVMObject {
    
    public var length: Double {
        Double(self.pythonObject.get_length())!
    }
    
    /// Returns a ``Group`` (collection of ``VMObject``s) containing the the instance’s tips.
    public var tips: Group {
        Group(self.pythonObject.get_tips())
    }
    
    /// Adds a tip to the instance.
    ///
    /// - Parameters:
    ///   - shape: The tip shape, `nil` for the default arrow shape.
    ///   - position: The position to add the tip. Note that if multiple shapes are added to the same position, they will be positioned in serial.
    @discardableResult
    public func addTip(shape: ArrowTipShape? = nil, at position: Position) -> Animation {
        let tip = self.pythonObject.create_tip(tip_shape: shape, at_start: position == .start)
        return MObject(tip).show().preAction {
            self.pythonObject.add_tip(tip, at_start: position == .start)
        }
    }
    
    
    public enum Position: Equatable {
        case start, end
    }
    
}
