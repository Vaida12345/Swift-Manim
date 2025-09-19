# ``Manim``

The Swift Interface for Manim

## Overview

Create beautiful mathematical animations.

![Example](VectorArrow)

With Swift-native API.

```swift
@main
class VectorArrow: Scene {

    override func body(width: Int?) {
        super.body(width: width)

        let dot = Dot()
        let arrow = Arrow(from: .center, to: [2, 2])
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

## Topics

### Animation

- <doc:Animations>
