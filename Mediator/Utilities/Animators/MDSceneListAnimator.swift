//
//  MDSceneListAnimator.swift
//  Mediator
//
//  Created by VuVince on 8/12/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

enum MDSceneListAnimatorType {
    case present
    case dismiss
}

class MDSceneListAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var type = MDSceneListAnimatorType.present
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return UIConstant.transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch type {
        case .present:
            let scenesNavi = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! UINavigationController
            let videoVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! MDVideoViewController
            present(scenesNavi: scenesNavi, from: videoVC, in: transitionContext)
            break
        default:
            let scenesNavi = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! UINavigationController
            let videoVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! MDVideoViewController
            dismiss(scenesNavi: scenesNavi, from: videoVC, in: transitionContext)
            break
        }
    }
    
}

private extension MDSceneListAnimator {
    func present(scenesNavi: UINavigationController, from videoVC: MDVideoViewController, in context: UIViewControllerContextTransitioning) {
        let container = context.containerView
        scenesNavi.view.frame = container.bounds
        scenesNavi.view.alpha = 0
        container.insertSubview(scenesNavi.view, aboveSubview: videoVC.view)
        UIView.animate(withDuration: transitionDuration(using: context), animations: {
            scenesNavi.view.alpha = 1
        }) { (finished) in
            context.completeTransition(finished)
            container.insertSubview(videoVC.view, belowSubview: scenesNavi.view)
        }
    }
    
    func dismiss(scenesNavi: UINavigationController, from videoVC: MDVideoViewController, in context: UIViewControllerContextTransitioning) {
        let container = context.containerView
        videoVC.view.frame = container.bounds
        container.insertSubview(videoVC.view, belowSubview: scenesNavi.view)
        UIView.animate(withDuration: transitionDuration(using: context), animations: {
            scenesNavi.view.alpha = 0
        }) { (finished) in
            context.completeTransition(finished)
        }
    }
    
}
