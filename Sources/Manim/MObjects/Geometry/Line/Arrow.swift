//
//  Arrow.swift
//  swiftManim
//
//  Created by Vaida on 2023/10/13.
//




/// An arrow.
public class Arrow: Line {
    
    required init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    /// Creates the arrow
    ///
    /// - Parameters:
    ///   - padding: The distance of the arrow from its start and end points.
    public init(start: any PointLike, end: any PointLike, padding: Double = 0, tip: some ArrowTipShape = .default) {
        super.init(
            args: [
                ("start", start.pyDescription),
                ("end", end.pyDescription),
                ("buff", padding.description)
            ] + (tip.identifier.isEmpty ? [] : [("tip_shape", tip.identifier)])
        )
        
        if let start = start as? Method<Point> {
            self.set.start(to: start)
        }
        if let end = end as? Method<Point> {
            self.set.end(to: end)
        }
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
    /// Create a custom arrow tip.
    ///
    /// - Important: Due to language features, one should **always** call the initializer of `base` within the closure.
    public static func custom(base: @autoclosure () -> MObject) -> CustomArrowTipShape { CustomArrowTipShape(base: base) }
}


public struct CustomArrowTipShape: ArrowTipShape {
    
    public var identifier: String
    
    fileprivate init(identifier: String) {
        self.identifier = identifier
    }
    
    fileprivate init(base: () -> MObject) {
        shouldOverrideInit = true
        let base = base()
        shouldOverrideInit = false
        
        guard base.__base != nil else {
            fatalError("Cannot form a CustomArrowTipShape, as you did not initialize it within CustomArrowTipShape(base:)")
        }
        
        let className = __formVariableName(base: "\(base.__base!)ArrowTip")
        self.identifier = className
        
        Generator.main.add("class \(className)(ArrowTip, \(base.__base!)):")
        indentCount += 1
        Generator.main.add("def __init__(self, length=0.35, **kwargs):")
        indentCount += 1
        let args = __formArgs(base.__args!).dropLast().dropFirst()
        Generator.main.add("\(base.__base!).__init__(self, \(args.isEmpty ? "" : "\(args), ")**kwargs)")
        Generator.main.add("self.width = length")
        Generator.main.add("self.stretch_to_fit_height(length)")
        indentCount -= 2
        Generator.main.add("")
    }
    
}
