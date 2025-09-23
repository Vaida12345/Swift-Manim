
# Swift-Manim

This package offers a Swift wrapper to Manim. This package uses [ManimCE](https://docs.manim.community/en/stable/index.html), and is essentially a interpreter from Swift to Python. It uses the engine of [ManimCE](https://docs.manim.community/en/stable/index.html).

To use this package, please make sure you have [ManimCE](https://docs.manim.community/en/stable/index.html) [installed](https://docs.manim.community/en/stable/installation.html).


# Gallery

Examples of using Manim.

## VectorArrow

![Example](https://github.com/Vaida12345/Swift-Manim/blob/main/Sources/Manim/Documentation.docc/Resources/VectorArrow.png)

```swift
@main
class VectorArrow: Scene {

    override func body(width: Int?) {
        super.body(width: width)

        let dot = Dot()
        let arrow = Arrow(start: .center, end: [2, 2])
        let numberPlane = NumberPlane()
        
        let originText = Text("(0, 0)")
        originText.move(nextTo: dot, position: .down)
        
        let tipText = Text("(2, 2)")
        tipText.move(nextTo: arrow.end, position: .right)
        
        self.add(dot, arrow, numberPlane, originText, tipText)
    }
}
```


## Moving Dots

![video](https://github.com/Vaida12345/Swift-Manim/blob/main/Sources/Manim/Documentation.docc/Resources/MovingDots.mov)

```swift
@main
class MovingDots: Scene {

    override func body(width: Int?) {
        super.body(width: width)

        let dot1 = Dot(color: .blue)
        let dot2 = Dot(color: .green)
        
        let group = Group(dot1, dot2)
        group.arrange(direction: .right)
        
        let line = Line(start: dot1.center, end: dot2.center)
        line.set(color: .red)
        line.addUpdater { line in
            line.become(Line(start: dot1.center, end: dot2.center))
            line.set(color: .red)
        }
        
        dot1.show()
        dot2.show()
        line.show()
        
        
        let x = dot1.x.tracker()
        let y = dot2.y.tracker()
        
        withAnimation {
            x += 4
            y += 4
        }
    }
}
```

## Different Lag Ratios
![Video](https://github.com/user-attachments/assets/8f91cfa7-e8ea-4c97-b3c5-36362ca183d2)

```swift
let ratios = [0, 0.1, 0.5, 1]

// Create dot groups
let group = HStack(Dot(), Dot(), Dot(), Dot())
let groups = HStack(spacing: 1, group, group.copied(), group.copied(), group.copied())

groups.show()

// Label groups
let label = Text("lagRatio", fontSize: 36)
label.move(nextTo: groups, position: .up, padding: 1.5)
label.show()

for (group, ratio) in zip(groups, ratios) {
    let text = Text("\(ratio)", fontSize: 36)
    text.move(nextTo: group, position: .up)
    text.show()
}

// Animate groups with different lag_ratios
withAnimation {
    for (group, ratio) in zip(groups, ratios) {
        group.shift(by: [0, -2, 0])
            .lagRatio(ratio)
    }
}

withAnimation {
    groups.shift(by: [0, 2, 0])
        .lagRatio(0.1)
        .duration(2)
}
```
