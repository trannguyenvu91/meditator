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
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            let videoVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! MDVideoViewController
            present(toViewController: toVC!, from: videoVC, in: transitionContext)
            break
        default:
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
            let videoVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! MDVideoViewController
            dismiss(toViewController: toVC!, from: videoVC, in: transitionContext)
            break
        }
    }
    
}

private extension MDSceneListAnimator {
    func present(toViewController: UIViewController, from videoVC: MDVideoViewController, in context: UIViewControllerContextTransitioning) {
        let container = context.containerView
        toViewController.view.frame = getOffScreenFrame(container.bounds)
        container.insertSubview(toViewController.view, aboveSubview: videoVC.view)
        
        UIView.animate(withDuration: transitionDuration(using: context), delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
            toViewController.view.frame = container.bounds
        }) { (finished) in
            context.completeTransition(finished)
            container.insertSubview(videoVC.view, belowSubview: toViewController.view)
        }
    }
    
    func dismiss(toViewController: UIViewController, from videoVC: MDVideoViewController, in context: UIViewControllerContextTransitioning) {
        let container = context.containerView
        videoVC.view.frame = container.bounds
        container.insertSubview(videoVC.view, belowSubview: toViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: context), delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
            toViewController.view.frame = self.getOffScreenFrame(container.bounds)
        }) { (finished) in
            context.completeTransition(finished)
        }
    }
    
    func getOffScreenFrame(_ screenFrame: CGRect) -> CGRect {
        return CGRect(x: screenFrame.minX, y: screenFrame.maxY, width: screenFrame.width, height: screenFrame.height)
    }
    
}

extension MDSceneListAnimator: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        type = .dismiss
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        type = .present
        return self
    }
    
}
