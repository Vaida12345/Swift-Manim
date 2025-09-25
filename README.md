
# Swift-Manim

A Swift wrapper to Manim.

This package uses the engine of [ManimCE](https://docs.manim.community/en/stable/index.html) and [PythonKit](https://github.com/pvieito/PythonKit) for Python interoperation.

To use this package, please make sure you have [ManimCE](https://docs.manim.community/en/stable/index.html) [installed](https://docs.manim.community/en/stable/installation.html).


## Gallery

Examples of using Manim.

### VectorArrow

![Example](https://github.com/Vaida12345/Swift-Manim/blob/main/Sources/Manim/Documentation.docc/Resources/VectorArrow.png)

```swift
import Manim

try await withManim { scene in
    let dot = Dot(color: .blue.opacity(0.5))
    let arrow = Vector([2, 2])
    let numberPlane = NumberPlane()
    
    let originText = Text("(0, 0)")
    originText.move(below: dot)
    
    let tipText = Text("(2, 2)")
    tipText.move(rightOf: arrow.end)
    
    scene.add(dot, arrow, numberPlane, originText, tipText)
}
```


### Moving Dots

![video](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/MovingDots.mov)

```swift
try await withManim { scene in
    let dot1 = Dot(color: .blue)
    let dot2 = Dot(color: .green)
    
    scene.arrange(dot1, dot2, direction: .right)
    
    let line = Line(from: dot1.center, to: dot2.center, color: .red)
    line.addUpdater(initialCall: true) {
        line.moveTo(start: dot1.center, end: dot2.center)
    }
    
    scene.add(dot1, dot2, line)
    
    let x = dot1.track(\.x)
    let y = dot2.track(\.y)
    
    withAnimation(in: .serial) {
        x += 4
        y += 4
    }
} configuration: {
    $0.preview = false
}
```

### Different Lag Ratios
![Video](https://github.com/user-attachments/assets/8f91cfa7-e8ea-4c97-b3c5-36362ca183d2)

```swift
try await withManim { scene in
    let ratios = [0, 0.1, 0.5, 1]
    
    // Create dot groups
    let group = HStack(Dot(), Dot(), Dot(), Dot())
    let groups = HStack(spacing: 1, group, group.copied(), group.copied(), group.copied())
    
    groups.show()
    
    // Label groups
    let label = Text("lagRatio", fontSize: 36)
    label.move(above: group, padding: 1.5)
    label.show()
    
    for (group, ratio) in zip(groups.children, ratios) {
        let text = Text("\(ratio)", fontSize: 36)
        text.move(above: group)
        text.show()
    }
    
    // Animate groups with different lag_ratios
    withAnimation(in: .serial) {
        for (group, ratio) in zip(groups.children, ratios) {
            group.shift(by: [0, -2, 0])
                .lagRatio(ratio)
        }
    }
    
    withAnimation {
        groups.shift(by: [0, 2, 0])
            .lagRatio(0.1)
            .duration(2)
    }
} 
```

### Matrix Multiplication

[See Here](https://github.com/Vaida12345/Swift-Manim/blob/main/Sources/Manim/Documentation.docc/matmul.md)


## Getting Started

`Swift-Manim` uses [Swift Package Manager](https://www.swift.org/documentation/package-manager/) as its build tool. If you want to import in your own project, it's as simple as adding a `dependencies` clause to your `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/Vaida12345/Swift-Manim.git", branch: "main")
]
```
and then adding the appropriate module to your target dependencies.
```swift
.product(name: "Manim", package: "Swift-Manim"),
```

### Using Xcode Package support

You can add this framework as a dependency to your Xcode project by clicking File -> Swift Packages -> Add Package Dependency. The package is located at:
```
https://github.com/Vaida12345/Swift-Manim.git
```

### Setup Environment

`Swift-Manim` uses Python [ManimCE](https://docs.manim.community/en/stable/index.html) as its engine, hence it is essential to setup Python and let `Swift-Manim` know where to look.

Please follow [this guide](https://github.com/Vaida12345/Swift-Manim/blob/main/Sources/Manim/Documentation.docc/Setup.md) to setup your environment.

## Documentation

This package uses [DocC](https://www.swift.org/documentation/docc/) for documentation.

## Credits

- [ManimCE](https://docs.manim.community/en/stable/index.html): The underlying engine. This Swift package is simply a wrapper for this engine.
- [PythonKit](https://github.com/pvieito/PythonKit.git): This package offers interoperation between Swift and Python, allowing you to run Python code in Swift.
