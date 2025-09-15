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
        
        dot.show()
        arrow.show()
        numberPlane.show()
        originText.show()
        tipText.show()
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
        
        let line = Line(start: dot1.center.attached(), end: dot2.center.attached())
        line.set(color: .red)
        
        dot1.show(animation: .none)
        dot2.show(animation: .none)
        line.show(animation: .none)
        

        let x = ValueTracker()
        let y = ValueTracker()
        
        dot1.set.x(x)
        dot2.set.y(y)
        
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
let groups = HStack(group, group.copied(), group.copied(), group.copied(), spacing: 1)

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
