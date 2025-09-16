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
    ///   - start: The starting point of the arrow.
    ///   - end: The ending point of the arrow.
    ///   - padding: The distance of the arrow from its start and end points.
    ///   - tip: The tip shape.
    public init(from start: some PointProtocol, to end: some PointProtocol, padding: Double = 0, tip: some ArrowTipShape = .default) {
        super.init(
            args: [
                ("start", start.representation),
                ("end", end.representation),
                ("buff", padding.description)
            ] + (tip.identifier.isEmpty ? [] : [("tip_shape", tip.identifier)])
        )
    }
    
    override init(base: String? = nil, args: Closure.Arguments) {
        super.init(base: base, args: args)
    }
    
}


@MainActor
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
        Generator.main.indentCount += 1
        Generator.main.add("def __init__(self, length=0.35, **kwargs):")
        Generator.main.indentCount += 1
        let args = base.__args!.representation.dropLast().dropFirst()
        Generator.main.add("\(base.__base!).__init__(self, \(args.isEmpty ? "" : "\(args), ")**kwargs)")
        Generator.main.add("self.width = length")
        Generator.main.add("self.stretch_to_fit_height(length)")
        Generator.main.indentCount -= 2
        Generator.main.add("")
    }
    
}
