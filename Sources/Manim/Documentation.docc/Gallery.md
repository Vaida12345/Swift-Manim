
# Gallery

Examples of using Manim.

## VectorArrow

![image](VectorArrow)

```swift
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


## Moving Dots

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

    withAnimation {
        x += 4
        y += 4
    }
} configuration: {
    $0.preview = false
}
```

## Different Lag Ratios

![video](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/lagRatio.mov)

View source code in [animation.md](<doc:Animations>)

## Matmul

<doc:matmul>
