//
//  Transictions.swift
//  GuilhermeCL
//
//  Created by Guilherme Leite Colares on 4/15/15.
//  Copyright (c) 2015 Guilherme Leite Colares. All rights reserved.
//

import Foundation
import UIKit

class Transitions: NSObject, UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate{
    
    var presenting:Bool = false;
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.66
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if self.presenting {
            self.animatePresentationAnimation(transitionContext)
        }else{
            self.animateDismissalAnimation(transitionContext)
        }
    }
    
    func animatePresentationAnimation(transitionContext:UIViewControllerContextTransitioning){
        var toViewController:UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var finalFrame:CGRect = transitionContext.finalFrameForViewController(toViewController)
        
        var containerView:UIView = transitionContext.containerView()
        containerView.addSubview(toViewController.view)
        
        var kScreenHeight: CGFloat = Utils.KScreenHeight()
        
        toViewController.view.frame = CGRectOffset(finalFrame, 0, kScreenHeight)
        UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 0.62, initialSpringVelocity: 0.82, options: UIViewAnimationOptions(),
            animations: {
                toViewController.view.frame = finalFrame
            }, completion: { (finished: Bool) in
                transitionContext.completeTransition(true)
        })
    }
    
    func animateDismissalAnimation(transitionContext:UIViewControllerContextTransitioning){
        var fromViewController: UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        var toViewController: UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        transitionContext.containerView().addSubview(toViewController.view)
        transitionContext.containerView().addSubview(fromViewController.view)
        
        UIView.animateWithDuration(0.24, animations: {
            fromViewController.view.frame = CGRectMake(0, -32, Utils.WIDTH(toViewController.view), Utils.HEIGHT(toViewController.view))
            }, completion: { (finished:Bool) in
                UIView.animateWithDuration(0.24,
                    animations: {
                        fromViewController.view.frame = CGRectMake(0, Utils.HEIGHT(toViewController.view), Utils.WIDTH(toViewController.view), Utils.HEIGHT(toViewController.view))
                        
                    },completion:{(finished:Bool) in
                        transitionContext.completeTransition(true)
                    }
                )
        })
    }
}
