
# ``MObject``


## Topics

### Transformation

- <doc:Position>
- ``MObject/scaleToFit(width:)``
- ``MObject/scaleToFit(height:)``
- ``MObject/apply(matrix:center:)``

### Lifetime
- ``MObject/show(animation:)``
- ``MObject/become(_:matchHeight:matchWidth:matchDepth:matchCenter:stretch:)``
- ``MObject/transform(to:style:)``
- ``MObject/hide(animation:)``

### Action
- ``MObject/circumscribe(shape:style:color:)``
- ``MObject/flash(lineLength:lineCount:radius:strokeWidth:color:)``
- ``MObject/focus(color:)``
- ``MObject/indicate(scale:color:)``
- ``MObject/shake()``
- ``MObject/showPassingFlash(duration:)``

### Decedents
- ``VMObject/children``
- ``MObject/add(_:)``
- ``MObject/remove(_:)``
- ``VMObject/copied()``

### Updater
- ``MObject/addUpdater(index:initial:handler:)-(_,_,()->Void)``
- ``MObject/addUpdater(index:initial:handler:)-(_,_,(Double)->Void)``
- ``Updater``
- ``MObject/track(_:)->ValueTracker``
- ``MObject/track(_:)->Projection<T>``
- ``MObject/bind(_:to:)``

### Color
- ``MObject/color``
- ``MObject/set(color:)``

### State
- ``MObject/save()``
- ``State/restore()``
- ``State``

### Spawn MObjects
- ``MObject/trace(_:color:width:dissipatingTime:)``
- ``MObject/underline(padding:)``

### Structures
- ``CircumscribeShape``
- ``CircumscribeStyle``
