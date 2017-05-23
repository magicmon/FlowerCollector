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
            transitionContext.completeTransition(true)
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
            transitionContext.completeTransition(true)
        }
    }
}

// MARK: - Detail
class FlowerCollectionViewDetailPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        let sourceVC = fromViewController as? UICollectionViewController
        let destinationVC = toViewController as! FlowerDetailController
        
        transitionContext.containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
        
        guard let selectedItem = sourceVC?.collectionView?.indexPathsForSelectedItems?.first else {
            transitionContext.completeTransition(true)
            return
        }
        guard let infoCell = sourceVC?.collectionView?.cellForItem(at: selectedItem) as? FlowerInfosCell else {
            transitionContext.completeTransition(true)
            return
        }
        
        // snapBackgroundView (cell의 ContentView)
        let snapBackgroundView = UIView(frame: infoCell.contentView.frame)
        snapBackgroundView.backgroundColor = infoCell.contentView.backgroundColor
        snapBackgroundView.frame.origin = infoCell.contentView.convert(.zero, to: nil)
        transitionContext.containerView.addSubview(snapBackgroundView)
        
        
        // snapImageView (cell의 ImageView)
        guard let snapImageView = infoCell.imageView.snapshotView() else {
            transitionContext.completeTransition(true)
            return
        }
        snapImageView.frame.origin = infoCell.imageView.convert(.zero, to: nil)
        transitionContext.containerView.addSubview(snapImageView)
        
        destinationVC.view.isHidden = true
        
        let animationScaleX: CGFloat = destinationVC.imageView.width / infoCell.imageView.width
        let animationScaleY: CGFloat = destinationVC.imageView.height / infoCell.imageView.height
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            // snap View
            snapImageView.transform = CGAffineTransform(scaleX: animationScaleX, y: animationScaleY)
            snapImageView.center = CGPoint(x: destinationVC.imageView.center.x, y: destinationVC.imageView.center.y)
            
            snapBackgroundView.transform = CGAffineTransform(scaleX: animationScaleX * 3, y:animationScaleY * 3)
            
            
            sourceVC?.view.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }) { (finished) in
            
            snapImageView.removeFromSuperview()
            snapBackgroundView.removeFromSuperview()
            
            sourceVC?.view.transform = .identity
            
            destinationVC.view.isHidden = false
            
            transitionContext.completeTransition(true)
        }
    }
}

class FlowerCollectionViewDetailPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        let sourceVC = fromViewController as! FlowerDetailController
        let destinationVC = toViewController as! FlowerInfosController
        
        transitionContext.containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
        
        // to
        guard let selectedItem = destinationVC.selectedIndexPath, let infoCell = destinationVC.collectionView?.cellForItem(at: selectedItem) as? FlowerInfosCell else {
            transitionContext.completeTransition(true)
            return
        }
        
        
        // from
        let snapBackgroundView = UIView(frame: infoCell.contentView.frame)
        snapBackgroundView.backgroundColor = infoCell.contentView.backgroundColor
        snapBackgroundView.frame.origin = infoCell.contentView.convert(.zero, to: nil)
        transitionContext.containerView.addSubview(snapBackgroundView)
        let defaultScaleX: CGFloat = sourceVC.imageView.width / infoCell.imageView.width
        let defaultScaleY: CGFloat = sourceVC.imageView.height / infoCell.imageView.height
        snapBackgroundView.transform = CGAffineTransform(scaleX: defaultScaleX * 3, y: defaultScaleY * 3)
        
        guard let snapImageView = sourceVC.imageView.snapshotView() else {
            transitionContext.completeTransition(true)
            return
        }
        snapImageView.frame.origin = sourceVC.imageView.convert(.zero, to: nil)
        transitionContext.containerView.addSubview(snapImageView)
        
        // scale
        let animationScaleX: CGFloat = infoCell.imageView.frame.size.width / sourceVC.imageView.frame.size.width
        let animationScaleY: CGFloat = infoCell.imageView.frame.size.height / sourceVC.imageView.frame.size.height
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            
            snapImageView.transform = CGAffineTransform(scaleX: animationScaleX, y: animationScaleY)
            let cellImageOrigin: CGPoint = infoCell.imageView.convert(.zero, to: nil)
            snapImageView.frame = CGRect(x: cellImageOrigin.x, y: cellImageOrigin.y, width: infoCell.imageView.frame.size.width, height: infoCell.imageView.frame.size.height)
            
            snapBackgroundView.transform = CGAffineTransform.identity
            
        }) { (finished) in
            
            snapImageView.removeFromSuperview()
            snapBackgroundView.removeFromSuperview()
            
            transitionContext.completeTransition(true)
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
    
    var width: CGFloat {
        return self.frame.size.width
    }
    
    var height: CGFloat {
        return self.frame.size.height
    }
}
