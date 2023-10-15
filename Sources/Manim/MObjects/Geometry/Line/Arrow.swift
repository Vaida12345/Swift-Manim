//
//  Arrow.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//

import Foundation


/// An arrow.
public class Arrow: Line {
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    public init(start: any PointLike, end: any PointLike, tip: some ArrowTipShape = .default) {
        super.init(args: [("start", start.pyDescription), ("end", end.pyDescription)] + (tip.identifier.isEmpty ? [] : [("tip_shape", tip.identifier)]))
    }
    
    override init(base: String? = nil, args: Args) {
        super.init(base: base, args: args)
    }
    
}


public protocol ArrowTipShape: Equatable {
    
    var identifier: String { get }
    
}


public struct SystemArrowTipShape: ArrowTipShape {
    
    public var identifier: String
    
    fileprivate init(identifier: String) {
        self.identifier = identifier
    }
    
    public var filled: SystemArrowTipShape {
        switch self {
        case .diamond:
            SystemArrowTipShape(identifier: "ArrowSquareFilledTip")
        case .circle:
            SystemArrowTipShape(identifier: "ArrowCircleFilledTip")
        case .triangle:
            SystemArrowTipShape(identifier: "ArrowTriangleFilledTip")
        default:
            fatalError()
        }
    }
}

extension ArrowTipShape where Self == SystemArrowTipShape {
    public static var diamond: SystemArrowTipShape { SystemArrowTipShape(identifier: "ArrowSquareTip") }
    public static var circle: SystemArrowTipShape { SystemArrowTipShape(identifier: "ArrowCircleTip") }
    public static var triangle: SystemArrowTipShape { SystemArrowTipShape(identifier: "ArrowTriangleTip") }
    public static var `default`: CustomArrowTipShape { CustomArrowTipShape(identifier: "") }
}


public struct CustomArrowTipShape: ArrowTipShape {
    
    public var identifier: String
    
    fileprivate init(identifier: String) {
        self.identifier = identifier
    }
    
}
