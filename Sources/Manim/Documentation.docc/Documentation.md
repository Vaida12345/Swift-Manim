# ``Manim``

The Swift Interface for Manim

## Overview

A Swift wrapper to Manim, framework for creating beautiful mathematical animations.

This package uses the engine of [ManimCE](https://docs.manim.community/en/stable/index.html) and [PythonKit](https://github.com/pvieito/PythonKit) for Python interoperation.


![Example](VectorArrow)

With Swift-native API.

```swift
try await withManim { scene in
    let dot = Dot()
    let arrow = Vector([2, 2])
    let numberPlane = NumberPlane()

    let originText = Text("(0, 0)")
    originText.move(below: dot)

    let tipText = Text("(2, 2)")
    tipText.move(rightOf: arrow.end)

    scene.add(dot, arrow, numberPlane, originText, tipText)
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
