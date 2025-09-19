
# Animations

Animating transitions.


## Apply Animation

Most methods that implies animation could be animated. We can use the `withAnimation` to wrap around a block to create an animation.

```swift
// not animated
originText.align(.down, to: dot)

// animated
withAnimation {
    originText.align(.down, to: dot)
}
```

The blocks, or ``AttachedAnimation``s, comes with some declarations that can be attached to the blocks, for example, you can use ``Animation/duration(_:)`` to set the duration, or ``Animation/delay(_:)`` to set the delay.
```swift
withAnimation(in: .parallel) {
    dot.move(to: [0, -1])
    dot2.move(to: [2, -1])
        .delay(0.1)
}
```

You can explore ``withAnimation(_:in:body:)`` for more options.

### Lag Ratio

Please refer to the video for details.

![Video](lagRatio)

```swift
let ratios = [0, 0.1, 0.5, 1]

// Create dot groups
let group = HStack(Dot(), Dot(), Dot(), Dot())
let groups = HStack(spacing: 1, group, group.copied(), group.copied(), group.copied())

groups.show()

// Label groups
let label = Text("lagRatio")
label.fontSize = 36
label.move(nextTo: groups, position: .up, padding: 1.5)
label.show()

for (group, ratio) in zip(groups, ratios) {
    let text = Text("\(ratio)")
    text.fontSize = 36
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


## Wait

You can freeze the scene using ``Scene/wait(_:)`` function.

```swift
withAnimation(in: .parallel, lagRatio: 1) {
    originText.fill(.red)
    dot.fill(.blue)
}

// Let's wait 2 seconds.
self.wait(2)
```

## Binding

It is also possible to [observe](``MObject/addUpdater(index:initialCall:handler:)``) changes.

```swift
let dot1 = Dot(at: [2, 2], color: .blue)
let dot2 = Dot(at: .center, color: .green)

dot1.show()
dot2.show()

withAnimation {
    dot1.x.bind(to: dot2.x)
    dot2.move(to: [-2, 0])
}
```

In the example above, the `x`-coordinate of `dot1` is bound to the `x`-coordinate of `dot2`, and `dot1` moves as `dot2` changes its `x`-coordinate.

## Topics

### Functions
- ``withAnimation(_:in:body:)``
- ``MObject/action(_:)``
- ``MObject/transform(to:option:)``

### Structures
- ``Animation``
- ``ActionAnimation``
- ``AttachedAnimation``
- ``Transform``
