//
//  FlowerCollectionViewAnimator.swift
//  FlowerCollector
//
//  Created by magicmon on 2017. 5. 19..
//  Copyright © 2017년 magicmon. All rights reserved.
//

import UIKit

class FlowerCollectionViewPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    internal var animationDuration: Double! = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        
        transitionContext.containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
        
        toViewController.view.alpha = 0.0
        UIView.animate(withDuration: animationDuration, animations: {
            fromViewController.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            toViewController.view.alpha = 1.0
        }) { (finished) in
            fromViewController.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
