
# Gallery

Examples of using Manim.

## VectorArrow

![image](VectorArrow)

```swift
try await withManim { scene in
    let dot = Dot()
    let arrow = Vector([2, 2])
    let numberPlane = NumberPlane()
    
    let originText = Text("(0, 0)")
    originText.move(below: dot)
    
    let tipText = Text("(2, 2)")
    tipText.move(rightOf: arrow.end)
    
    scene.add(numberPlane, dot, arrow, originText, tipText)
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
    line.moveTo(start: dot1.track(\.center), end: dot2.track(\.center))

    scene.add(line, dot1, dot2)

    let x = dot1.track(\.x)
    let y = dot2.track(\.y)

    withAnimation {
        x += 4
    }

    withAnimation(in: .parallel) {
        x.become(-4)
        y += 2
    }
} configuration: {
    $0.preview = false
    $0.quality = .high
}
```

## Different Lag Ratios

@TabNavigator {
    @Tab("Video") {
        ![Video](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/lagRatio.mov)
    }
    @Tab("Source Code") {
        ```swift
        let ratios = [0, 0.1, 0.5, 1]
        
        // Create dot groups
        let group = HStack(Dot(), Dot(), Dot(), Dot())
        let groups = HStack(spacing: 1, group, group.copied(), group.copied(), group.copied())
        
        groups.show()
        
        // Label groups
        let label = Text("lagRatio", fontSize: 36)
        label.move(above: groups, padding: 1.5)
        label.show()
        
        for (group, ratio) in zip(groups.children, ratios) {
            let text = Text("\(ratio)", fontSize: 36)
            text.move(above: group)
            text.show()
        }
        
        // Animate groups with different lagRatios
        withAnimation {
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
        ```
    }
}

## NumberLine

![video](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/DecimalNumber.mov)

```swift
@ValueTracker var value = 0.0
let number = DecimalNumber($value, format: .precision(fractionLength: 4))
let dot = Dot()
let numberLine = NumberLine(range: Range(0...4))
scene.add(VStack(numberLine, number), dot)

dot.addUpdater {
    dot.move(to: numberLine.convert(number: value))
}
withAnimation {
    $value.become(.pi)
}

scene.sleep()
withAnimation {
    $value.become(0)
}
```

## Scene Camera

![Preview](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/scene_camera.mov)

```swift
let dot = Dot()
let plane = NumberPlane(margin: 2)

let text = Text("(\(dot.x), \(dot.y))")
text.addUpdater(initial: true) {
    text.become(Text("(\(dot.x.formatted(.number.precision(2))), \(dot.y.formatted(.number.precision(2))))"))
    text.move(rightOf: dot)
}
scene.add(plane, dot, text)

withAnimation(.linear, in: .parallel) {
    dot.move(to: [1, 1])
    scene.camera.move(to: [1, 1])
}
```

## Brace
![Preview](Gallery_Brace)

```swift
let dot1 = Dot(at: [-2, -1])
let dot2 = Dot(at: [ 2,  1])

let line = Line(from: dot1.center, to: dot2.center, color: .orange)

let brace1 = Brace(line)
let brace1Text = brace1.label("Horizontal distance")

let brace2 = Brace(line, direction: .angle(line.angle + .degrees(90)))
let brace2Text = brace2.label(math: "x-x_1")

scene.add(line, dot1, brace1, brace1Text, dot2, brace2, brace2Text)
```

## Matmul

![Video](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/matmul.mov)

[Source code](<doc:matmul>)
