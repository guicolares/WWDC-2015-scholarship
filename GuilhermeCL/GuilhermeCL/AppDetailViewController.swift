//
//  AppDetailViewController.swift
//  GuilhermeCL
//
//  Created by Guilherme Leite Colares on 4/16/15.
//  Copyright (c) 2015 Guilherme Leite Colares. All rights reserved.
//

import UIKit
import StoreKit
import MediaPlayer

class AppDetailViewController: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate,SKStoreProductViewControllerDelegate {
    var  screenshots, identifier:NSString!
    var icon,name, descriptionApp:String!
    
    var animator:UIDynamicAnimator!
    var screenshotIndex:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animator = UIDynamicAnimator(referenceView: self.view)
        self.initializeDismissalSwipe()
        self.setUpBackgroundView()
        self.setUpInterface()
        self.setUpScreenShots()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initializeDismissalSwipe(){
        var swipeRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeToDismiss")
        swipeRecognizer.direction = UISwipeGestureRecognizerDirection.Right
        swipeRecognizer.delegate = self
        self.view.addGestureRecognizer(swipeRecognizer)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        let imageView:UIImageView? = self.view.viewWithTag(401) as? UIImageView
        if touch.view == imageView {
            return false
        }
        return true
    }
    
    func setUpBackgroundView(){
        var backgroundImage:UIImageView! = UIImageView(frame: self.view.bounds)
        backgroundImage.contentMode = UIViewContentMode.ScaleToFill
        backgroundImage.clipsToBounds = true
        backgroundImage.image = UIImage(named: self.icon)
        self.view.addSubview(backgroundImage)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let image:UIImage = backgroundImage.image!.applyAppViewEffect()!
            dispatch_async(dispatch_get_main_queue(), {
                backgroundImage.image = image
            })
        })
    }
    
    func setUpInterface(){
        var container:AppView = AppView(frame: CGRectMake(0, 30, Utils.WIDTH(self.view), 80))
        container.backgroundColor = UIColor.clearColor()
        container.setNewAppIconImage(UIImage(named: self.icon)!)
        container.setNewAppNameString(self.name)
        if self.identifier.length == 0 {
            container.circularIcon = true
        }else{
            var appStore:UIImageView = UIImageView(frame: CGRectMake(90, 55, 10, 10))
            appStore.backgroundColor = UIColor.clearColor()
            appStore.clipsToBounds = true
            appStore.image = UIImage(named: "App")
            container.addSubview(appStore)
            container.button.addTarget(self, action: "openInAppStore", forControlEvents: UIControlEvents.TouchUpInside)
        }
        self.view.addSubview(container)
        
        var closeButton:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        closeButton.setImage(UIImage(named: "ic_close.png"), forState: UIControlState.Normal)
        closeButton.backgroundColor = UIColor.clearColor()
        closeButton.frame = CGRectMake(Utils.WIDTH(self.view)-64, 30, 64, 80)
        closeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0)
        closeButton.addTarget(self, action: "swipeToDismiss", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(closeButton)
        
        var height:CGFloat = Utils.heightForLabelWithText(self.descriptionApp, constraint: CGSizeMake(Utils.WIDTH(self.view)-30, CGFloat(MAXFLOAT)), font: Utils.normalFontWithSize(16.0))
        
        var descriptionLabel:UILabel = UILabel(frame: CGRectMake(15, 116, Utils.WIDTH(self.view)-30, height))
        descriptionLabel.text = self.descriptionApp
        descriptionLabel.textColor = UIColor.whiteColor()
        descriptionLabel.font = Utils.normalFontWithSize(16.0)
        descriptionLabel.numberOfLines = 0
        self.view.addSubview(descriptionLabel)
    }
    
    func setUpScreenShots(){
        //make sure there are screenshots before attempting to set up
        if self.screenshots.length > 0{
            let padding:CGFloat = (Utils.WIDTH(self.view) - (68*3))/4
            var xVal:CGFloat = padding
            
            //Adjust for 3.5-inch screens
            var witdh, height, bottomPadding:CGFloat
            witdh = 78.0
            height = 150.0
            bottomPadding = 15.0
            if(Utils.KScreenHeight() == 480){
                witdh = 62.0
                height = 110.0
                bottomPadding = 10.0
            }
            
            let imageArray:NSArray = self.screenshots.componentsSeparatedByString(",")
            for var index = 0; index < imageArray.count; index++ {
                var screenshot:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
                screenshot.frame = CGRectMake(xVal, Utils.KScreenHeight()-height-bottomPadding, witdh, height)
                screenshot.contentMode = UIViewContentMode.ScaleToFill
                screenshot.clipsToBounds = true
                screenshot.backgroundColor = UIColor.clearColor()
                screenshot.setBackgroundImage(UIImage(named: imageArray[index] as! String), forState: UIControlState.Normal)
                screenshot.tag = 50 + index
                screenshot.addTarget(self, action: "screenshotTapped:", forControlEvents: UIControlEvents.TouchUpInside)
                self.view.addSubview(screenshot)
                
                xVal += 68+padding
            }
        }
    }
    
    func screenshotTapped(sender:AnyObject){
        let tag:NSInteger = (sender as! UIControl).tag - 50
        let imageArray:NSArray = self.screenshots.componentsSeparatedByString(",")
        
        self.screenshotIndex = tag + 50
        var imageView:UIImageView = UIImageView(frame: CGRectMake(0, Utils.HEIGHT(self.view), Utils.WIDTH(self.view), Utils.HEIGHT(self.view)))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: imageArray.objectAtIndex(tag) as! String)
        imageView.userInteractionEnabled = true
        imageView.tag = 401
        self.view.addSubview(imageView)
        
        var tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "closeScreenshotImageView:")
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tapGesture)
        
        var imageSnap: UISnapBehavior = UISnapBehavior(item: imageView, snapToPoint: self.view.center)
        imageSnap.damping = 0.79
        self.animator.addBehavior(imageSnap)
    }
    
    func closeScreenshotImageView(gesture:UIGestureRecognizer){
        self.animator.removeAllBehaviors()
        
        let screeshotPreviewButton:UIButton = self.view.viewWithTag(self.screenshotIndex) as! UIButton
        var imageView:UIImageView = self.view.viewWithTag(401) as! UIImageView
        
        UIView.animateWithDuration(0.24,
            animations: {
                imageView.frame = screeshotPreviewButton.frame
            }, completion:{ (finished:Bool) in
                imageView.removeFromSuperview()
        })
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func openInAppStore(){
        if(self.identifier != ""){
            let parameters = [SKStoreProductParameterITunesItemIdentifier : self.identifier]
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            var store: SKStoreProductViewController = SKStoreProductViewController()
            store.delegate = self
            store.loadProductWithParameters(parameters,
                completionBlock: {result, error in
                    if result {
                        self.presentViewController(store,
                            animated: true, completion: nil)
                    }
                    
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
        }
       
    }
    
    func productViewControllerDidFinish(viewController:
        SKStoreProductViewController!) {
            viewController.dismissViewControllerAnimated(true,
                completion: nil)
    }
 
    func swipeToDismiss(){
       self.dismissViewControllerAnimated(true, completion: nil)
    }
}
