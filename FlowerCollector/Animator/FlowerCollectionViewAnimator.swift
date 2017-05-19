//
//  FlowerCollectionViewAnimator.swift
//  FlowerCollector
//
//  Created by magicmon on 2017. 5. 19..
//  Copyright © 2017년 magicmon. All rights reserved.
//

import UIKit

fileprivate var animationDuration: Double! = 0.4

class FlowerCollectionViewPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
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

class FlowerCollectionViewPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        
        transitionContext.containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
        
        
        fromViewController.view.alpha = 1.0
        toViewController.view.alpha = 0.0
        toViewController.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        UIView.animate(withDuration: animationDuration, animations: {
            toViewController.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            fromViewController.view.alpha = 0.5
            toViewController.view.alpha = 1.0
        }) { (finished) in
            fromViewController.view.alpha = 1.0
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
