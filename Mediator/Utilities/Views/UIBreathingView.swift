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
    private var inhaleFragments, holdingFraments, exhaleFragments: [Float]!
    private var cycleDuration: Float!
    private var labelRatio: Float!
    
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
                     inhaleFragments: [Float],
                     exhaleFragments: [Float],
                     holdingFraments: [Float],
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
        backgroundColor = UIColor.darkGray
        setupLayout()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        label.layer.cornerRadius = label.frame.width / 2.0
        label.layer.masksToBounds = true
    }
    
    func setupLayout() {
        setupLabel()
    }
    
    func setupLabel() {
        self.addSubview(label)
        label.text = "Hello World"
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
    
}
