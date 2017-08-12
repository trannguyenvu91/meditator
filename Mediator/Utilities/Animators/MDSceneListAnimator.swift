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
            let scenesVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! MDSceneListViewController
            let videoVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! MDVideoViewController
            present(scenesVC: scenesVC, from: videoVC, in: transitionContext)
            break
        default:
            let scenesVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! MDSceneListViewController
            let videoVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! MDVideoViewController
            dismiss(scenesVC: scenesVC, from: videoVC, in: transitionContext)
            break
        }
    }
    
}

private extension MDSceneListAnimator {
    func present(scenesVC: MDSceneListViewController, from videoVC: MDVideoViewController, in context: UIViewControllerContextTransitioning) {
        let container = context.containerView
        scenesVC.view.frame = container.bounds
        scenesVC.view.alpha = 0
        container.insertSubview(scenesVC.view, aboveSubview: videoVC.view)
        UIView.animate(withDuration: transitionDuration(using: context), delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            scenesVC.view.alpha = 1
        }) { (finished) in
            context.completeTransition(finished)
        }
    }
    
    func dismiss(scenesVC: MDSceneListViewController, from videoVC: MDVideoViewController, in context: UIViewControllerContextTransitioning) {
        UIView.animate(withDuration: transitionDuration(using: context), delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            scenesVC.view.alpha = 0
        }) { (finished) in
            scenesVC.view.removeFromSuperview()
            context.completeTransition(finished)
        }
    }
    
}
