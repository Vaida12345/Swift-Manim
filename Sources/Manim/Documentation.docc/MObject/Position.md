
# Position & Moving

APIs for positioning and moving ``MObject``s.

## Origin

Imagine yourself working in a math world, and that's Manim.

![example](VectorArrow)

The [center](PointProtocol/center) of the canvas is `(0, 0)`. Points in top-right quadrant have positive axis values.


### Object Origin

Follow the same guideline, the ``MObject/origin`` of an object is defined to be its center point.

![example](origin)


## Positioning

Although you can use ``MObject/origin`` or ``Transformable/move(to:alignedEdges:coordinateMask:)-(Point,_,_)`` to retrieve and move objects using its absolute coordinate, which you can use the ``NumberPlane`` as a reference. It is suggested to use relative layouts, such as ``Transformable/move(below:padding:)-(Point,_)`` or ``SceneProxy/arrange(_:direction:spacing:)-(MObject...,_,_)``.



## Topics

### Coordinates
- ``MObject/x``
- ``MObject/y``
- ``MObject/zIndex``

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
- ``Transformable/move(to:alignedEdges:coordinateMask:)-(Point,_,_)``
- ``Transformable/move(above:padding:)-(Point,_)``
- ``Transformable/move(below:padding:)-(Point,_)``
- ``Transformable/move(leftOf:padding:)-(Point,_)``
- ``Transformable/move(rightOf:padding:)-(Point,_)``
- ``Transformable/move(_:of:padding:)-(_,Point,_)``

### Implicit Move
- ``Transformable/shift(by:)``
- ``Transformable/moveAlong(pathOf:)``
- ``Transformable/rotate(angle:about:axis:)``
- ``Transformable/scale(_:stroke:)``
- ``Transformable/flip(axis:)``

### Arrangement
- ``SceneProxy/arrange(_:direction:spacing:)-(MObject...,_,_)``
- ``HStack``
- ``VStack``
