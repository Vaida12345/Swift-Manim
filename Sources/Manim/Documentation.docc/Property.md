# Property

Properties and bridge between Swift and Python.


## Read-Write Property

Certain properties are designed to be extremely adaptive, able to evaluate both constants and runtime values.

```swift
let first = Dot()
first.color = .blue

let second = Dot()
second.move(nextTo: first, placing: .right)
second.color = first.color

first.show()
second.show()
```

In the example above, both dots are set to the color of ``ReadWriteProperty/blue``.


## Syncing Property

With [updaters](``MObject/addUpdater(index:initialCall:handler:)``), you can keep two values in sync. For example, you can make sure the color of `third` always stays the same as that of `first`.

```swift
let third = Dot()
third.color.bind(to: first.color)
```

## Topics

### Object Properties

- ``ReadableProperty``
- ``ReadWriteProperty``

### Control Properties

- ``ValueTracker``
