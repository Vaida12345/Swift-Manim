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
        originText.move(nextTo: dot, placing: .down)

        let tipText = Text("(2, 2)")
        tipText.move(nextTo: arrow.end, placing: .right)

        self.add(dot, arrow, numberPlane, originText, tipText)
    }
}
```

## Topics

### Animation

- <doc:Animations>


### Main Objects
- ``MObject``
- ``Scene``

### Common Structures
- ``Point``
- ``Color``


### Python Generation
These structures are developed to facilitate Python Script generation.

- ``PyObject``
- ``PythonScriptConvertible``
- ``Generator``
