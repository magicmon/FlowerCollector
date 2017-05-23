//
//  NavigationControllerDelegate.swift
//  FlowerCollector
//
//  Created by magicmon on 2017. 5. 19..
//  Copyright © 2017년 magicmon. All rights reserved.
//

import UIKit

class NavigationControllerDelegate : NSObject, UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            if fromVC is FlowerInfosController {
                return FlowerCollectionViewDetailPushAnimator()
            } else {
                return FlowerCollectionViewPushAnimator()
            }
        } else {
            if fromVC is FlowerDetailController {
                return FlowerCollectionViewDetailPopAnimator()
            } else {
                return FlowerCollectionViewPopAnimator()
            }
        }
    }
}
