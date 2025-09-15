
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

The blocks, or ``AttachedAnimation``s, comes with some declarations that can be attached to the blocks, for example, you can use ``AttachedAnimation/duration(_:)`` to set the duration, or ``Animation/delay(_:)`` to set the delay.
```swift
withAnimation(in: .parallel) {
    dot.move(to: [0, -1])
    dot2.move(to: [2, -1])
        .delay(0.1)
}
```

You can explore ``withAnimation(_:in:body:)`` for more options.


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
