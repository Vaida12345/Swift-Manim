
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
        let arrow = Arrow(start: .center, end: [2, 2])
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
        
        let group = VGroup(dot1, dot2)
        group.arrange(direction: .right)
        
        let line = Line(start: dot1.center.attached(), end: dot2.center.attached())
        line.set(color: .red)
        
        dot1.show(animation: .none)
        dot2.show(animation: .none)
        line.show(animation: .none)
        

        let x = ValueTracker()
        let y = ValueTracker()
        
        dot1.set.x(x)
        dot2.set.y(y)
        
        withAnimation {
            x += 4
            y += 4
        }
    }
}
```

