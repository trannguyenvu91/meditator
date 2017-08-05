//
//  MDProgressLayer.swift
//  Mediator
//
//  Created by VuVince on 8/5/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

protocol MDProgressLayerProtocol: NSObjectProtocol {
    func progress(layer: MDProgressLayer, update progress: Double)
}

class MDProgressLayer: CALayer {
    @objc dynamic var progress: Double = 0
    var progressDuration: Double = 0
    weak var progressDelegate: MDProgressLayerProtocol?
    
    override init(layer: Any) {
        super.init(layer: layer)
        if let copyLayer =  layer as? MDProgressLayer{
            self.progress = copyLayer.progress
            self.progressDelegate = copyLayer.progressDelegate
            self.progressDuration = copyLayer.progressDuration
        }
    }
    
    init(duration: Double, delegate: MDProgressLayerProtocol) {
        super.init()
        self.progressDuration = duration
        self.progressDelegate = delegate
        self.progress = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        progressDelegate = aDecoder.decodeObject(forKey: "progressDelegate") as? MDProgressLayerProtocol
        progress = aDecoder.decodeDouble(forKey: UIConstant.progressAnimation)
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(Double(progress), forKey: UIConstant.progressAnimation)
        aCoder.encode(progressDelegate as AnyObject?, forKey: "progressDelegate")
    }
    
    override class func needsDisplay(forKey key: String) -> Bool {
        if key == UIConstant.progressAnimation {
            return true
        } else {
            return super.needsDisplay(forKey: key)
        }
    }
    
    override func draw(in ctx: CGContext) {
        progressDelegate?.progress(layer: self, update: self.progress)
    }
    
    func animateProgress(enable: Bool) {
        if enable && hasAnimation() {
            resumeAnimation()
        } else if enable {
            addAnimation()
        } else {
            pauseAnimation()
        }
    }
    
    func addAnimation() {
        let animation = CABasicAnimation(keyPath: UIConstant.progressAnimation)
        animation.duration = progressDuration
        animation.beginTime = 0
        animation.fromValue = Double(0)
        animation.toValue = Double(1)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        animation.repeatCount = HUGE
        add(animation, forKey: UIConstant.progressAnimation)
    }
    
    func hasAnimation() -> Bool {
        if let hasAnimation = animationKeys()?.contains(UIConstant.progressAnimation) {
            return hasAnimation
        }
        return false
    }
    
}

extension MDProgressLayer: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }
}
