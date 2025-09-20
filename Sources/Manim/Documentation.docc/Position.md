
# Position & Moving

APIs for positioning and moving ``MObject``s.


## Topics

### Coordinates
- ``MObject/x``
- ``MObject/y``

### More Coordinates
- ``MObject/center``
- ``MObject/bottom``
- ``MObject/top``
- ``MObject/left``
- ``MObject/right``

### Drawing Coordinates
- ``MObject/origin``
- ``MObject/start``
- ``MObject/end``

### Move Suite
- ``MObject/move(to:alignedEdges:coordinateMask:)-(PointProtocol,_,_)``
- ``MObject/move(to:alignedEdges:coordinateMask:)-(MObject,_,_)``
- ``MObject/move(nextTo:placing:padding:)``
- ``MObject/move(above:padding:)``
- ``MObject/move(below:padding:)``
- ``MObject/move(leftOf:padding:)``
- ``MObject/move(rightOf:padding:)``
- ``MObject/next(to:position:padding:)``

### Implicit Move
- ``MObject/shift(by:)``
- ``MObject/moveAlong(pathOf:)``
