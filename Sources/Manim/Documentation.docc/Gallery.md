
# Gallery

Examples of using Manim.

## VectorArrow

![image](VectorArrow)

```swift
@main
class VectorArrow: Scene {

    override func body(width: Int?) {
        super.body(width: width)

        let dot = Dot()
        let arrow = Arrow(from: .center, to: [2, 2])
        let numberPlane = NumberPlane()
        
        let originText = Text("(0, 0)")
        originText.move(nextTo: dot, position: .down)
        
        let tipText = Text("(2, 2)")
        tipText.move(nextTo: arrow.end, position: .right)
        
        dot.show()
        arrow.show()
        numberPlane.show()
        originText.show()
        tipText.show()
    }
}
```


## Moving Dots

![video](MovingDots.mov)

```swift
@main
class MovingDots: Scene {

    override func body(width: Int?) {
        super.body(width: width)

        let dot1 = Dot(color: .blue)
        let dot2 = Dot(color: .green)

        let group = Group(dot1, dot2)
        group.arrange(direction: .right)

        let line = Line(start: dot1.center, end: dot2.center)
        line.set(color: .red)
        line.addUpdater { line in
            line.become(Line(start: dot1.center, end: dot2.center))
            line.set(color: .red)
        }

        dot1.show()
        dot2.show()
        line.show()


        let x = dot1.x.tracker()
        let y = dot2.y.tracker()

        withAnimation {
            x += 4
            y += 4
        }
    }
}
```

## Different Lag Ratios

![video](lagRatio)

View source code in [animation.md](<doc:Animations>)
