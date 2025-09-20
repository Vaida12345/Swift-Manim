
# Position & Moving

APIs for positioning and moving ``MObject``s.

## Origin

Imagine yourself working in a math world, and that's Manim.

![example](VectorArrow)

The [center](PointProtocol/center) of the canvas is `(0, 0)`. Points in top-right quadrant have positive axis values.


### Object Origin

Follow the same guideline, the ``MObject/origin`` of an object is defined to be its center point.

![example](origin)



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
