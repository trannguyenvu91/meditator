//
//  UIBreathingView.swift
//  Mediator
//
//  Created by VuVince on 8/4/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit
import SnapKit

class UIBreathingView: UIView {
    private var inhaleColor, exhaleColor, holdingColor, labelColor: UIColor!
    private var inhaleFragments, holdingFraments, exhaleFragments: [Range<Double>]!
    private var cycleDuration: Float!
    private var labelRatio: Float!
    let lineWith: CGFloat = 8.0
    
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
                     inhaleFragments: [Range<Double>],
                     exhaleFragments: [Range<Double>],
                     holdingFraments: [Range<Double>],
                     labelRatio:Float,
                     inhaleColor: UIColor,
                     exhaleColor: UIColor,
                     holdingColor: UIColor,
                     labelColor: UIColor) {
        
        self.init(frame: frame)
        self.cycleDuration = duration
        self.inhaleFragments = inhaleFragments
        self.holdingFraments = holdingFraments
        self.exhaleFragments = exhaleFragments
        self.labelRatio = labelRatio
        self.inhaleColor = inhaleColor
        self.holdingColor = holdingColor
        self.exhaleColor = exhaleColor
        self.labelColor = labelColor
        backgroundColor = UIColor.clear
        setupLayout()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        label.layer.cornerRadius = label.frame.width / 2.0
        label.layer.masksToBounds = true
        let center = label.center
        let radius = Float(min(rect.width, rect.height)) / 2.0
        //inhale lines
        for range in inhaleFragments {
            drawArc(at: center, radius: radius, between: range, color: inhaleColor)
        }
        //holding lines
        for range in holdingFraments {
            drawArc(at: center, radius: radius, between: range, color: holdingColor)
        }
        //exhale lines
        for range in exhaleFragments {
            drawArc(at: center, radius: radius, between: range, color: exhaleColor)
        }
    }
    
    func setupLayout() {
        setupLabel()
    }
    
    private func setupLabel() {
        self.addSubview(label)
        label.text = inhaleText
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
    
    private func drawArc(at center: CGPoint,
                 radius: Float,
                 between range: Range<Double>,
                 color: UIColor) {
        let bezier = UIBezierPath(arcCenter: center,
                                  radius: CGFloat(radius) - lineWith,
                                  startAngle: CGFloat(.pi * 2 * range.lowerBound - .pi / 2.0),
                                  endAngle: CGFloat(.pi * 2 * range.upperBound - .pi / 2.0),
                                  clockwise: true)
        bezier.lineWidth = lineWith
        color.setStroke()
        bezier.stroke()
    }
    
}
