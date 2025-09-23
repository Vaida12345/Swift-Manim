
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
        originText.move(nextTo: dot, placing: .down)
        
        let tipText = Text("(2, 2)")
        tipText.move(nextTo: arrow.end, placing: .right)
        
        self.add(dot, arrow, numberPlane, originText, tipText)
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

## Matrix Multiplication

```swift
import Manim

@main
class VectorArrow: Scene {
    
    override func configure(_ configuration: inout Generator.Configuration) {
        configuration.quality = .high
    }
    
    override func body(width: Int?) {
        super.body(width: width)
        
        // MARK: - initial scene
        // lhs
        let lhs = Matrix([[1, 2], [3, 4]])
        let multiplication = MathTex("\\times")
        let rhs = Matrix([[5, 6], [7, 8]])
        
        let stack = HStack(lhs, multiplication, rhs)
        
        let title = Text("Matrix Multiplication")
        title.fontSize = 60
        title.move(above: stack, padding: 1.25)
        
        withAnimation(in: .parallel) {
            lhs.show(animation: .write)
            multiplication.show(animation: .write)
                .delay(0.5)
            rhs.show(animation: .write)
                .delay(0.25)
            title.show(animation: .write)
                .delay(0.75)
        }
        
        self.sleep(for: .seconds(2))
        
        // MARK: - move rhs, remove title, add result matrix
        let result = Matrix([[19, 22], [43, 50]])
        result.move(to: rhs)
        for i in 0..<4 {
            result.entries[i].color = .black
        }
        
        withAnimation(in: .parallel) {
            title.hide(animation: .fadeOut(shift: .up))
            multiplication.set(color: .black)
                .delay(0.1)
            rhs.shift(by: [0, 2.25])
                .delay(0.5)
        }
        
        let resultText = Text("result")
        resultText.fontSize = 30
        resultText.move(above: result, padding: 0)
        withAnimation {
            result.show(animation: .write)
            resultText.show(animation: .write)
        }
        
        self.sleep(for: .seconds(2))
        
        // MARK: - first box
        
        let addition = MathTex("{{5}}{{14}}")
        addition.move(to: result.entries[0])
        
        let topLeftEntryBox = Rectangle(width: addition.width, height: addition.height)
        topLeftEntryBox.move(to: result.entries[0])
        topLeftEntryBox.stroke(.yellow)
        
        withAnimation(in: .parallel) {
            topLeftEntryBox.show(animation: .drawBorderThenFill)
            resultText.fill(.gray, opacity: 0.5)
                .delay(0.5)
        }
        
        withAnimation(in: .parallel) {
            lhs.entries[2].fill(.gray, opacity: 0.5)
            lhs.entries[3].fill(.gray, opacity: 0.5)
            rhs.entries[1].fill(.gray, opacity: 0.5)
            rhs.entries[3].fill(.gray, opacity: 0.5)
        }
        
        self.sleep(for: .seconds(1))
        
        withAnimation(in: .parallel) {
            lhs.entries[0].copied().replacementTransform(to: addition.children[0])
            rhs.entries[0].copied().replacementTransform(to: addition.children[0])
        }
        
        self.sleep(for: .seconds(1))
        
        withAnimation(in: .parallel) {
            lhs.entries[1].copied().replacementTransform(to: addition.children[1])
            rhs.entries[2].copied().replacementTransform(to: addition.children[1])
        }
        
        withAnimation(in: .parallel) {
            addition.replacementTransform(to: result.entries[0])
            result.entries[0].set(color: .white)
            topLeftEntryBox.hide(animation: .fadeOut())
        }
        
        self.sleep(for: .seconds(1))
        
        // MARK: - other entries
        for i in 1...3 {
            var lhsEntries: [Int] {
                i == 1 ? [0, 1] : [2, 3]
            }
            var rhsEntries: [Int] {
                [0, 2].contains(i) ? [0, 2] : [1, 3]
            }
            var nonlhsEntries: [Int] {
                i == 1 ? [2, 3] : [0, 1]
            }
            var nonrhsEntries: [Int] {
                [0, 2].contains(i) ? [1, 3] : [0, 2]
            }
            let addition = {
                switch i {
                case 1: MathTex("{{6}}{{16}}")
                case 2: MathTex("{{15}}{{28}}")
                case 3: MathTex("{{18}}{{32}}")
                default: fatalError()
                }
            }()
            
            withAnimation(in: .parallel) {
                result.entries[i - 1].fill(.gray, opacity: 0.5)
                for i in nonlhsEntries {
                    lhs.entries[i].fill(.gray, opacity: 0.5)
                    lhs.entries[i].fill(.gray, opacity: 0.5)
                }
                for i in nonrhsEntries {
                    rhs.entries[i].fill(.gray, opacity: 0.5)
                    rhs.entries[i].fill(.gray, opacity: 0.5)
                }
                for i in lhsEntries {
                    lhs.entries[i].fill(.white)
                    lhs.entries[i].fill(.white)
                }
                for i in rhsEntries {
                    rhs.entries[i].fill(.white)
                    rhs.entries[i].fill(.white)
                }
            }
            
            addition.zIndex = 999
            addition.move(to: result.entries[i])
            
            withAnimation(in: .parallel) {
                lhs.entries[lhsEntries[0]].copied().replacementTransform(to: addition.children[0])
                rhs.entries[rhsEntries[0]].copied().replacementTransform(to: addition.children[0])
            }
            
            withAnimation(in: .parallel) {
                lhs.entries[lhsEntries[1]].copied().replacementTransform(to: addition.children[1])
                rhs.entries[rhsEntries[1]].copied().replacementTransform(to: addition.children[1])
            }
            
            withAnimation(in: .parallel) {
                addition.replacementTransform(to: result.entries[i])
                result.entries[i].set(color: .white)
            }
        }
        
        // highlight result
        withAnimation(in: .parallel) {
            for i in 0..<4 {
                result.entries[i].fill(.white)
                lhs.entries[i].fill(.gray, opacity: 0.5)
                rhs.entries[i].fill(.gray, opacity: 0.5)
            }
        }
        
        // MARK: - rearrange
        
        let equalSign = MathTex("=")
        equalSign.move(rightOf: result)
        
        withAnimation(in: .parallel) {
            resultText.hide()
            multiplication.set(color: .white)
            rhs.move(to: result)
                .delay(0.25)
            equalSign.show()
            result.move(rightOf: equalSign)
        }
        
        withAnimation(in: .parallel) {
            for i in 0..<4 {
                lhs.entries[i].fill(.white)
                rhs.entries[i].fill(.white)
            }
        }
    }
}
```
