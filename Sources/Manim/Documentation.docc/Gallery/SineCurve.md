
# Sine Curve

Unit circle & sine wave

## Sine Curve & Unit Circle

![Video](https://github.com/Vaida12345/Swift-Manim/raw/refs/heads/main/Sources/Manim/Documentation.docc/Resources/sine_curve.mov)

The video demonstrates the generation of a sine wave by showing a point moving in circular motion, with its vertical projection traced over time to form the wave. 

Pedagogically, this helps students connect abstract trigonometric functions to tangible geometric motion, reinforcing the relationship between circular rotation and oscillatory behavior. By observing how uniform angular motion translates into a periodic vertical displacement, learners can better grasp key sine wave properties, including amplitude, period, and phase, and understand that the wave’s shape arises naturally from circular motion rather than as an arbitrary graph.

```swift
let axes = Axes(domain: Range(-3, 18), range: Range(-2, 2), width: 21, height: 4, xStyle: [], yStyle: [])
axes.zIndex = -999

let circle = Circle()
circle.origin = axes.convert([-1, 0], from: .axis, to: .canvas)
circle.show()

let circleText = Text("Unit Circle")
circleText.move(below: circle, padding: 0.5)
circleText.show()

let diameter = Line(from: circle.center - [1, 0], to: circle.center + [1, 0])
diameter.color = axes.color

scene.camera.move(to: circle.origin)

let radius = Line(from: circle.center, to: [sqrt(2) / 2, sqrt(2) / 2])
@ValueTracker var theta = Angle.degrees(45).radians
radius.moveTo(start: .constant(circle.center), end: .constant(circle.center) + [cos(theta), sin(theta)])

let sineLine = Line(from: circle.center, to: [sqrt(2) / 2, 0])
sineLine.moveTo(start: .constant(circle.center) + [cos(theta), 0], end: .constant(circle.center) + [cos(theta), sin(theta)])
sineLine.color = .yellow

let sineText = MathTex("")
sineText.addUpdater(initial: true) { _ in
    sineText.become(MathTex("\\sin(\(theta, format: .number.precision(2)))"))
    sineText.scale(0.75)
    sineText.color = .yellow.opacity(0.75)
    sineText.move(.right, of: sineLine.center)
}

withAnimation(in: .parallel) {
    radius.show(animation: .grow(from: circle.center))
    sineLine.show(animation: .grow(from: .up))
        .delay(0.25)
    sineText.show(animation: .fadeIn(shift: .right))
        .delay(0.3)
    diameter.show(animation: .grow(from: circle.center))
        .delay(0.75)
}

withAnimation(.easeIn) { ($theta += .pi).duration(2) }
withAnimation(.linear) { ($theta += .pi * 2).duration(4) }

let labels = (1...4).map {
    let label = $0 == 1 ? MathTex("\\pi") : MathTex("\($0)\\pi")
    label.scale(0.75)
    label.center = axes.convert([Double($0) * .pi, 0], from: .axis, to: .canvas)
    label.shift(by: [0, -0.25])
    return label
}
let labelsGroup = Group(labels)

withAnimation(.linear, in: .parallel) {
    ($theta += .pi).duration(2)
    axes.show()
        .animation(.smooth)
    circleText.hide()
    scene.camera.move(to: [-3, 0])
    labelsGroup.show(animation: .fadeIn())
        .lagRatio(0.5)
}

withAnimation(.linear) {
    ($theta += .pi * 2 - Angle.degrees(45).radians)
        .duration(4 - 0.125)
}

theta = 0 // reset for the plot

let curve = Group()
curve.add(Line(from: axes.convert(.zero, from: .axis, to: .canvas), to: axes.convert(.zero, from: .axis, to: .canvas)))
let sineCurve = alwaysRedraw {
    let lastLine = curve.children.last!.as(Line.self)
    let newEnd = axes.convert([theta, sin(theta)], from: .axis, to: .canvas)
    let newLine = Line(from: lastLine.end, to: newEnd, color: .yellow)
    curve.add(newLine)
    return curve
}
sineCurve.show()

let linkingLine = Line(from: .zero, to: .zero)
linkingLine.show()
linkingLine.addUpdater(initial: true) {
    linkingLine.become(Line(from: circle.center + [cos(theta), sin(theta)], to: axes.convert([theta, sin(theta)], from: .axis, to: .canvas)))
    linkingLine.color = .gray.opacity(0.5)
    linkingLine.strokeWidth = 2
}

withAnimation(.linear) {
    ($theta += .pi * 4).duration(8)
}

withAnimation(.linear) {
    ($theta += .pi / 4).duration(1/2)
}

scene.sleep()
```
