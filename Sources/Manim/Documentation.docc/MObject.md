
# ``MObject``


## Topics

### Transformation

- <doc:Position>
- ``MObject/rotate(angle:axis:)``
- ``MObject/flip(axis:)``
- ``MObject/scale(_:)``
- ``MObject/apply(matrix:center:)``
- ``MObject/zIndex``

### Lifetime
- ``MObject/show(animation:)``
- ``MObject/become(_:matchHeight:matchWidth:matchDepth:matchCenter:stretch:)``
- ``MObject/transform(to:transform:)``
- ``MObject/replacementTransform(to:)``
- ``MObject/hide(animation:)``

### Action
- ``MObject/circumscribe(shape:style:color:)``
- ``MObject/flash(lineLength:lineCount:radius:strokeWidth:color:)``
- ``MObject/focus(opacity:color:)``
- ``MObject/indicate(scale:color:)``
- ``MObject/shake()``
- ``MObject/showPassingFlash(duration:)``

### Color & Style
- ``MObject/set(color:)``
- ``MObject/fill(_:opacity:)``
- ``MObject/stroke(_:width:opacity:)``

### Decedents
- ``MObject/children``
- ``MObject/add(_:)``
- ``MObject/remove(_:)``
- ``MObject/copied()``

### Updater
- ``MObject/addUpdater(index:initialCall:handler:)``
- ``MObject/track(_:)``
- ``MObject/bind(_:to:)``
