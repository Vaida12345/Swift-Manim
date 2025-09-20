
# ``MObject``


## Topics

### Transformation

- <doc:Position>
- ``MObject/rotate(angle:axis:)``
- ``MObject/flip(axis:)``
- ``MObject/scale(factor:)``
- ``MObject/apply(matrix:center:)``
- ``MObject/zIndex``

### Lifetime
- ``MObject/show(animation:)``
- ``MObject/action(_:)``
- ``MObject/become(_:matchHeight:matchWidth:matchDepth:matchCenter:stretch:)``
- ``MObject/transform(to:option:)``
- ``MObject/replacementTransform(to:)``
- ``MObject/hide(animation:)``

### Color & Style
- ``MObject/color``
- ``MObject/set(color:)``
- ``MObject/fill(_:opacity:)``
- ``MObject/stroke(_:width:opacity:)``

### Controlling States
Save and restore states
- ``MObject/state``
- ``MObject/State``

### Decedents
- ``MObject/add(_:)``
- ``MObject/attached()``
- ``MObject/copied()``

### Updater
- ``MObject/addUpdater(index:initialCall:handler:)``
