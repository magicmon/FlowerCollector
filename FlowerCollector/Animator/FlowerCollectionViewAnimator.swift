//
//  FlowerCollectionViewAnimator.swift
//  FlowerCollector
//
//  Created by magicmon on 2017. 5. 19..
//  Copyright © 2017년 magicmon. All rights reserved.
//

import UIKit


class FlowerCollectionViewPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        
        transitionContext.containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
        
        toViewController.view.alpha = 0.0
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
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
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        
        transitionContext.containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
        
        
        fromViewController.view.alpha = 1.0
        toViewController.view.alpha = 0.0
        toViewController.view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            toViewController.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            fromViewController.view.alpha = 0.5
            toViewController.view.alpha = 1.0
        }) { (finished) in
            fromViewController.view.alpha = 1.0
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}


class FlowerCollectionViewDetailPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!

        transitionContext.containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
        
        
        let sourceVC = fromViewController as? UICollectionViewController
        let destinationVC = toViewController as! FlowerDetailController
        
        guard let selectedItem = sourceVC?.collectionView?.indexPathsForSelectedItems?.first else { return }
        guard let infoCell = sourceVC?.collectionView?.cellForItem(at: selectedItem) as? FlowerInfosCell else { return }
        
        
        let snapBackgroundView = UIView(frame: infoCell.contentView.frame)
        snapBackgroundView.backgroundColor = infoCell.contentView.backgroundColor
        snapBackgroundView.frame.origin = infoCell.contentView.convert(.zero, to: nil)
        transitionContext.containerView.addSubview(snapBackgroundView)
        
        guard let snapView = infoCell.imageView.snapshotView() else { return }
        snapView.frame.origin = infoCell.imageView.convert(.zero, to: nil)
        transitionContext.containerView.addSubview(snapView)
        
        toViewController.view.isHidden = true
        
        let animationScaleX: CGFloat = destinationVC.imageView.frame.size.width / infoCell.imageView.frame.size.width
        let animationScaleY: CGFloat = destinationVC.imageView.frame.size.height / infoCell.imageView.frame.size.height
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            // snap View
            snapView.transform = CGAffineTransform(scaleX: animationScaleX, y: animationScaleY)
            snapView.center = CGPoint(x: destinationVC.imageView.center.x, y: destinationVC.imageView.center.y)
            
            snapBackgroundView.transform = CGAffineTransform(scaleX: animationScaleX * 2, y:animationScaleY * 2)
            
        }) { (finished) in
            
            snapView.removeFromSuperview()
            snapBackgroundView.removeFromSuperview()
            
            
            
            toViewController.view.isHidden = false
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}


extension UIView {
    func snapshotImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapshotImage
    }
    
    func snapshotView() -> UIView? {
        if let snapshotImage = snapshotImage() {
            return UIImageView(image: snapshotImage)
        } else {
            return nil
        }
    }
}
