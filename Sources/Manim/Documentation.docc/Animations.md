
# Animations

Animating transitions.


## Apply Animation

Most methods that implies animation could be animated. We can use the `withAnimation` to wrap around a block to create an animation.

```swift
// not animated
originText.move(below: dot)

// animated
withAnimation {
    originText.move(below: dot)
}
```

The blocks, or ``Animation``s, comes with some declarations that can be attached to the blocks, for example, you can use ``Animation/duration(_:)`` to set the duration, or ``Animation/delay(_:)`` to set the delay.
```swift
withAnimation(in: .parallel) {
    dot.move(to: [0, -1])
    dot2.move(to: [2, -1])
        .delay(0.1)
}
```

You can explore ``withAnimation(_:in:body:)`` or ``Animation`` for more options.

### Lag Ratio

You can specify the lag ratio to create an asynchronous effect of animating ``VMObject/children``. 

Please refer to the video for details.

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

## Wait

You can freeze the scene using ``SceneProxy/sleep(for:)`` function.

```swift
withAnimation(in: .parallel) {
    originText.fill(.red)
    dot.fill(.blue)
}

// Let's wait 2 seconds.
self.wait(for: .seconds(2))
```

## Binding

It is also possible to synchronize changes using ``MObject/track(_:)->Projection<T>`` or ``MObject/bind(_:to:)``.

```swift
let dot1 = Dot(at: [0, 2], color: .blue)
let dot2 = Dot(at: .center, color: .green)

scene.add(dot1, dot2)

dot1.bind(\.x, to: dot2.x)

withAnimation {
    dot2.move(to: [2, 0])
}
```

![Video](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/bind.mov)

## Topics

### Functions
- ``withAnimation(_:in:body:)``
- ``alwaysRedraw(using:)``

### Binding
- ``MObject/track(_:)->ValueTracker``
- ``MObject/track(_:)->Projection<T>``
- ``MObject/bind(_:to:)``

### MObjects
- ``TracedPath``
- ``MovingCamera``

### Structures
- ``ValueTracker``
- ``Projection``
- ``Animation``
- ``AttachedAnimation``
- ``WrappedAnimation``
- ``Transform``
- ``ShowAnimation``
- ``HideAnimation``
- ``RateFunction``
