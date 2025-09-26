
# ``MObject``


## Topics

### Transformation

- <doc:Position>
- ``MObject/rotate(angle:axis:)``
- ``MObject/flip(axis:)``
- ``MObject/scale(_:stroke:)``
- ``MObject/scaleToFit(width:)``
- ``MObject/scaleToFit(height:)``
- ``MObject/apply(matrix:center:)``

### Lifetime
- ``MObject/show(animation:)``
- ``MObject/become(_:matchHeight:matchWidth:matchDepth:matchCenter:stretch:)``
- ``MObject/transform(to:transform:)``
- ``MObject/replacementTransform(to:)``
- ``MObject/hide(animation:)``

### Action
- ``MObject/circumscribe(shape:style:color:)``
- ``MObject/flash(lineLength:lineCount:radius:strokeWidth:color:)``
- ``MObject/focus(color:)``
- ``MObject/indicate(scale:color:)``
- ``MObject/shake()``
- ``MObject/showPassingFlash(duration:)``

### Decedents
- ``MObject/children``
- ``MObject/add(_:)``
- ``MObject/remove(_:)``
- ``MObject/copied()``

### Updater
- ``MObject/addUpdater(index:initial:handler:)``
- ``MObject/Updater``
- ``MObject/track(_:)``
- ``MObject/bind(_:to:)``

### Color
- ``MObject/color``
- ``MObject/set(color:)``

### State
- ``MObject/save()``
- ``MObject/State/restore()``
- ``MObject/State``
