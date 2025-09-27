# ``Manim``

The Swift Interface for Manim

## Overview

A Swift wrapper to Manim, framework for creating beautiful mathematical animations.

This package uses the engine of [ManimCE](https://docs.manim.community/en/stable/index.html) and [PythonKit](https://github.com/pvieito/PythonKit) for Python interoperation.


![video](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/DecimalNumber.mov)

```swift
@ValueTracker var value = 0.0
let number = DecimalNumber($value, format: .precision(fractionLength: 4))
let dot = Dot()
let numberLine = NumberLine(range: Range(0...4))
scene.add(VStack(numberLine, number), dot)

dot.move(to: numberLine.convert(number: $value))
withAnimation {
    $value.become(.pi)
}
```

## Topics

### Getting Started
- <doc:Setup>

### Showcase
- <doc:Gallery>

### Animation

- <doc:Animations>

### Entry
- ``withManim(scene:configuration:)``
- ``MObject``
- ``SceneProxy``
- ``ConfigurationProxy``

### Concrete class
- <doc:Text-display>
- <doc:Line-display>
- <doc:Shape>
- <doc:Grouping>
- <doc:Intermediate>

### Common Structures
- ``Point``
- ``Color``
- ``Axis``
- ``Direction``
- ``Range``

