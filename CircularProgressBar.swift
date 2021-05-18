import UIKit

@IBDesignable
public class CircularProgressBar: UIView {
    
    var shapeLayer: CAShapeLayer!
    
    @IBInspectable var lineWidth: CGFloat = 1.5 {
        didSet {
            self.shapeLayer.lineWidth = lineWidth
        }
    }
    
    @IBInspectable var strokeColor: UIColor = UIColor.white {
        didSet {
            self.shapeLayer.strokeColor = strokeColor.cgColor
        }
    }

    // MARK: Inits
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override func prepareForInterfaceBuilder() {
        setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor.clear
        shapeLayer = CAShapeLayer()
        let startAngle: CGFloat = -.pi / 2
        let endAngle: CGFloat = startAngle + 2 * .pi
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width)/2, startAngle: startAngle, endAngle: endAngle, clockwise: true).reversing()
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        layer.addSublayer(shapeLayer)
    }

    func animate(duration: TimeInterval = 2) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = duration
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        shapeLayer.add(animation, forKey: "anim")
    }
}
