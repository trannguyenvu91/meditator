//
//  UIBreathingView.swift
//  Mediator
//
//  Created by VuVince on 8/4/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit
import SnapKit

public struct BreathFragment: Equatable {
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
    
    func getScaleFactor() -> CGFloat {
        switch state {
        case .inhale:
            return 1.3
        case .hold:
            return 1.0
        case .exhale:
            return 1.3
        default:
            return 1.0
        }
    }
    
    public static func ==(first: BreathFragment, second: BreathFragment) -> Bool {
        return first.state == second.state && first.range == second.range
    }
    
}

enum BreathState {
    case inhale
    case hold
    case exhale
    
    func getTitle() -> String {
        switch self {
        case .inhale:
            return UIConstant.breathing_Inhale
        case .hold:
            return UIConstant.breathing_hold
        case .exhale:
            return UIConstant.breathing_exhale
        }
    }
    
    func getAudioURL() -> URL? {
        var fileName = ""
        switch self {
        case .inhale:
            fileName = UIConstant.breathing_Inhale_file
            break
        case .hold:
            fileName = UIConstant.breathing_hold_file
            break
        case .exhale:
            fileName = UIConstant.breathing_exhale_file
            break
        }
        return Bundle.main.url(forResource: fileName, withExtension: UIConstant.breathing_audio_extension)
    }
    
}

protocol UIBreathingViewDelegate: NSObjectProtocol {
    func didChange(fragment: BreathFragment)
    func didUpdate(totalTime: Double)
}

class UIBreathingView: UIView {
    private var labelColor: UIColor!
    private var breathFragments: [BreathFragment]!
    private var cycleDuration: Double!
    private var labelRatio: Float!
    private let lineWith: CGFloat = 5.0
    private var movingIndicator: UIMarkView!
    private var label = UILabel()
    private var currentFragment: BreathFragment?
    var progressTimer: MDProgressTimer!
    
    
    weak var delegate: UIBreathingViewDelegate?
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame:CGRect,
                     duration: Double,
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
    
    func animate(_ enable: Bool) {
        if enable && hasAnimations() {
            resumeAllAnimations()
            progressTimer.fire(restart: false)
        } else if enable {
            animateIndicator()
            animateBreathing()
            progressTimer.fire(restart: true)
        } else {
            progressTimer.pause()
            pauseAllAnimations()
        }
    }
    
    deinit {
        progressTimer.pause()
    }
    
}

//MARK: Drawing, layout views
internal extension UIBreathingView {
    
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
        setupProgressLayer()
    }
    
    func setupLabel() {
        addSubview(label)
        label.layer.masksToBounds = true
        label.text = breathFragments.first?.state.getTitle()
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
    
    func setupMarkViews() {
        movingIndicator = UIMarkView(arcRadius: Double(lineWith * 1.5), stand: Double(lineWith), color: UIColor.white)
        movingIndicator.isHidden = true
        addSubview(movingIndicator)
    }
    
    func setupProgressLayer() {
        progressTimer = MDProgressTimer(duration: cycleDuration, delegate: self)
    }
    
    func drawArc(at center: CGPoint,
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

//MARK: CAAnimation
private extension UIBreathingView {
    
    func hasAnimations() -> Bool {
        if let indicatorAnimations = movingIndicator.layer.animationKeys(),
            let breatheAnimation = layer.animationKeys()
        {
            return indicatorAnimations.contains(UIConstant.indicatorAnimation) && breatheAnimation.contains(UIConstant.breathingAnimation)
        }
        return false
    }
    
    func resumeAllAnimations() {
        movingIndicator.layer.resumeAnimation()
        layer.resumeAnimation()
    }
    
    func pauseAllAnimations() {
        movingIndicator.layer.pauseAnimation()
        layer.pauseAnimation()
    }
    
    func animateIndicator() {
        let orbit = CAKeyframeAnimation()
        orbit.keyPath = "position"
        orbit.path = UIBezierPath(arcCenter: CGPoint(x: label.center.x - movingIndicator.frame.height / 2.0, y: label.center.y - movingIndicator.frame.height / 2.0),
                                  radius: bounds.width / 2.0 - movingIndicator.frame.height / 2.0,
                                  startAngle:  CGFloat(-.pi / 2.0),
                                  endAngle: 1.5 * .pi,
                                  clockwise: true).cgPath
        orbit.duration = CFTimeInterval(cycleDuration)
        orbit.isAdditive = true
        orbit.repeatCount = HUGE
        orbit.calculationMode = kCAAnimationPaced
        orbit.isRemovedOnCompletion = false
        orbit.rotationMode = kCAAnimationRotateAuto
        movingIndicator.isHidden = false
        movingIndicator.layer.add(orbit, forKey: UIConstant.indicatorAnimation)
    }
    
    func animateBreathing() {
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.duration = CFTimeInterval(cycleDuration)
        animation.isAdditive = true
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        
        let keyValues = getTransforms()
        animation.values = keyValues.transforms
        animation.keyTimes = keyValues.times
        layer.add(animation, forKey: UIConstant.breathingAnimation)
    }
    
    func getTransforms() -> (transforms: [CATransform3D], times: [NSNumber]) {
        var transforms = [CATransform3D]()
        var keyTimes = [NSNumber]()
        
        for fragment in breathFragments {
            if fragment.state != .hold {
                let scale: CGFloat = fragment.getScaleFactor()
                var begin = CATransform3DIdentity
                var end = CATransform3DMakeScale(scale, scale, 1)
                let beginTime = NSNumber(value: fragment.range.lowerBound)
                let endTime = NSNumber(value: fragment.range.upperBound)
                
                if fragment.state == .exhale {
                    swap(&begin, &end)
                }
                transforms.append(begin)
                transforms.append(end)
                keyTimes.append(beginTime)
                keyTimes.append(endTime)
            }
        }
        return (transforms, keyTimes)
    }
    
}

//MARK: MDProgressTimerDelegate
extension UIBreathingView: MDProgressTimerDelegate {
    func didUpdate(timer: MDProgressTimer, progress: Double) {
        delegate?.didUpdate(totalTime: timer.totalTime)
        for fragment in breathFragments {
            if let _current = currentFragment, fragment.range.contains(progress), _current != fragment {
                nofityChange(fragment: fragment)
                break
            } else if currentFragment == nil {
                nofityChange(fragment: fragment)
                break
            }
        }
    }
    
    func nofityChange(fragment: BreathFragment) {
        currentFragment = fragment
        label.text = fragment.state.getTitle()
        delegate?.didChange(fragment: fragment)
    }
    
}
