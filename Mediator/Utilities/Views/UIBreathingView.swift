//
//  UIBreathingView.swift
//  Mediator
//
//  Created by VuVince on 8/4/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit
import SnapKit

public struct BreathFragment {
    let range: Range<Double>!
    let state: BreathState!
    
    func getColor() -> UIColor {
        switch state {
        case .inhale:
            return UIColor.green
        case .hold:
            return UIColor.lightGray
        case .exhale:
            return UIColor.brown
        default:
            return UIColor.brown
        }
    }
    
    func getTitle() -> String {
        switch state {
        case .inhale:
            return "Breathe in"
        case .hold:
            return "Hold"
        case .exhale:
            return "Breathe out"
        default:
            return "Hummmm"
        }
    }
}

enum BreathState {
    case inhale
    case hold
    case exhale
}

class UIBreathingView: UIView {
    private var labelColor: UIColor!
    private var breathFragments: [BreathFragment]!
    private var cycleDuration: Float!
    private var labelRatio: Float!
    let lineWith: CGFloat = 5.0
    private var movingIndicator: UIMarkView!
    
    private var inhaleText = "Breathe in", holdText = "Hold", exhale = "Breathe out"
    var label = UILabel()
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame:CGRect,
                     duration: Float,
                     breathFragments: [BreathFragment],
                     labelRatio:Float,
                     labelColor: UIColor) {
        self.init(frame: frame)
        self.cycleDuration = duration
        self.breathFragments = breathFragments
        self.labelRatio = labelRatio
        self.labelColor = labelColor
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.layer.cornerRadius = label.frame.width / 2.0
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let center = label.center
        let radius = Float(min(rect.width, rect.height)) / 2.0
        for fragment in breathFragments {
            drawArc(at: center, radius: radius, fragment: fragment)
        }
    }
    
    func setupLayout() {
        backgroundColor = UIColor.clear
        setupLabel()
        setupMarkViews()
    }
    
    private func setupLabel() {
        addSubview(label)
        label.layer.masksToBounds = true
        label.text = breathFragments.first?.getTitle()
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = labelColor
        label.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalToSuperview().multipliedBy(labelRatio).priority(UIConstant.autoLayoutPriority_High)
            make.height.equalToSuperview().multipliedBy(labelRatio).priority(UIConstant.autoLayoutPriority_High)
            make.width.equalTo(label.snp.height)
        }
    }
    
    private func setupMarkViews() {
        movingIndicator = UIMarkView(arcRadius: Double(lineWith * 1.5), stand: Double(lineWith), color: UIColor.white)
        movingIndicator.isHidden = true
        addSubview(movingIndicator)
    }
    
    func animate(_ enable: Bool) {
        let orbit = CAKeyframeAnimation()
        orbit.keyPath = "position"
        orbit.path = UIBezierPath(arcCenter: CGPoint(x: label.center.x - movingIndicator.frame.height / 2.0, y: label.center.y - movingIndicator.frame.height / 2.0),
                                       radius: bounds.width / 2.0 - movingIndicator.frame.height / 2.0,
                                       startAngle:  -.pi / 2.0,
                                       endAngle: 1.5 * .pi,
                                       clockwise: true).cgPath
        orbit.duration = CFTimeInterval(cycleDuration)
        orbit.isAdditive = true
        orbit.repeatCount = HUGE
        orbit.calculationMode = kCAAnimationPaced
        orbit.isRemovedOnCompletion = false
        orbit.rotationMode = kCAAnimationRotateAuto
        orbit.delegate = self
        movingIndicator.isHidden = false
        movingIndicator.layer.add(orbit, forKey: "orbit")
    }
    
    private func drawArc(at center: CGPoint,
                         radius: Float,
                         fragment: BreathFragment) {
        let range = fragment.range!
        let bezier = UIBezierPath(arcCenter: center,
                                  radius: CGFloat(radius) - lineWith / 2.0,
                                  startAngle: CGFloat(.pi * 2 * range.lowerBound - .pi / 2.0),
                                  endAngle: CGFloat(.pi * 2 * range.upperBound - .pi / 2.0),
                                  clockwise: true)
        bezier.lineWidth = lineWith
        fragment.getColor().setStroke()
        bezier.stroke()
    }
}

extension UIBreathingView: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }
}
