//
//  ViewController.swift
//  GuilhermeCL
//
//  Created by Guilherme Leite Colares on 4/15/15.
//  Copyright (c) 2015 Guilherme Leite Colares. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UIViewControllerTransitioningDelegate {
    var animator: UIDynamicAnimator!
    var scrollView: UIScrollView? = UIScrollView()
    var backgroundImage, profileImage, arrowIndicator: UIImageView!
    var nameLabel, bioLabel: UILabel!
    var coletaTri, speakUp, radioOabrs, aboutMeContainer: AppView!
    var AppArray: NSArray = []
    var transictionManager: Transitions!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.transictionManager = Transitions()
        self.animator = UIDynamicAnimator(referenceView: self.scrollView!)
        
        self.AppArray = [
            [
                "ColetaTri",
                "coletaTri-60.png",
                "ColetaTri is the easiest way to tell you about times, days and if the collection is automated with the use of containers.You can use the geolocation to locate the nearest street and generate reminders to put your trash at the right time and not to forget the days of collection.You can also inform the street name for details of collection.",
                "coletaTri-ss1.png,coletaTri-ss2.png,coletaTri-ss3.png",
                "976185946",//App Store Identifier
            ],
            [
                "SpeakUp",
                "speakUp-60.png",
                "The main goal of this app is to integrate people with different levels of motor and speech difficulties. Our solution provides an interface for people to communicate by touch. We provide a simple way for users to create and convey messages using fully customizable buttons with familiar images and recorded sounds. To be lauched soon",
                "speakUp-ss1.png,speakUp-ss2.png,speakUp-ss3.png",
                "" //not yet
            ],
            [
                "RádioOABRS",
                "radioOabrs-60.png",
                "In addition to a distinguished musical repertoire in its programming, Radio also offers legal news from around the country, articles and dissemination of courses and events. Also you can create alerts when something is interesting on radio to be notificated. To be lauched soon",
                "oabrs-ss1.png,oabrs-ss2.png,oabrs-ss3.png",
                "" //not yet
            ]
        
        ]
        
        self.setUpScrollViewPageOne()
        self.setUpScrollViewPageTwo()
        self.animateScrollViewPageOne()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpScrollViewPageOne(){
        self.backgroundImage = UIImageView(image: UIImage(named:"background-origin.png"))
        self.backgroundImage?.frame = self.view.bounds
        self.backgroundImage?.contentMode = UIViewContentMode.ScaleAspectFill
        self.backgroundImage?.clipsToBounds = true
        self.view.addSubview(self.backgroundImage!)
        
        self.scrollView?.frame = self.view.bounds
        self.scrollView?.delegate = self
        self.scrollView?.backgroundColor = UIColor.clearColor()
        self.scrollView?.pagingEnabled = true
        self.scrollView?.showsHorizontalScrollIndicator = false
        self.scrollView?.contentSize = CGSizeMake(self.view.frame.size.width * 2, Utils.HEIGHT(self.view))
       
        self.scrollView?.scrollEnabled = false
        self.view.addSubview(self.scrollView!)
        
        self.profileImage = UIImageView(frame: CGRectMake( (self.view.frame.size.width )/2 , -160, 160, 160))
        self.profileImage?.image = UIImage(named: "profile.jpg")
        self.profileImage?.clipsToBounds = true
        self.profileImage?.layer.cornerRadius = 160/2
        self.scrollView?.addSubview(self.profileImage!)
        
        self.nameLabel = UILabel(frame: CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 44))
        self.nameLabel.backgroundColor = UIColor.clearColor()
        self.nameLabel.text = "Guilherme Leite Colares"
        self.nameLabel.textColor = UIColor.whiteColor()
        self.nameLabel.textAlignment = NSTextAlignment.Center
        self.nameLabel.font = Utils.normalFontWithSize(26.0)
        self.scrollView?.addSubview(self.nameLabel)
        
        var bioString: String = "Software Engineer, BEPID Student and System Analyst Undergraduate Student"
        var bioHeight: CGFloat = Utils.heightForLabelWithText(bioString, constraint: CGSizeMake(Utils.WIDTH(self.view) - 24, CGFloat(MAXFLOAT)) , font: Utils.lightFontWithSize(20.0))
        
        self.bioLabel = UILabel()
        self.bioLabel?.frame = CGRectMake(12, Utils.HEIGHT(self.view), Utils.WIDTH(self.view)-24, bioHeight)
        self.bioLabel?.textAlignment = NSTextAlignment.Center
        self.bioLabel?.backgroundColor = UIColor.clearColor()
        self.bioLabel?.text = bioString
        self.bioLabel?.font = Utils.lightFontWithSize(20.0)
        self.bioLabel?.textColor = UIColor.whiteColor()
        self.bioLabel?.numberOfLines = 0
        self.scrollView?.addSubview(self.bioLabel!)
        
        self.arrowIndicator = UIImageView(frame: CGRectMake(Utils.WIDTH(self.view)-20, Utils.HEIGHT(self.view)-24, 8, 12))
        self.arrowIndicator?.image = UIImage(named: "ic_arrow.png")
        self.arrowIndicator?.alpha = 0
        self.scrollView?.addSubview(self.arrowIndicator!)
    }
    
    func setUpScrollViewPageTwo(){
        var height:CGFloat = 80.0
        var originX:CGFloat = 60.0
        
        if(Utils.KScreenHeight() == 480){
            originX = 32.0
        }
        
        //About me
        self.aboutMeContainer = AppView(frame: CGRectMake(Utils.WIDTH(self.view)*2, originX, Utils.WIDTH(self.view), height))
        self.aboutMeContainer.backgroundColor = UIColor.clearColor()
        self.aboutMeContainer.setNewAppIconImage(UIImage(named: "profile-60.jpg")!)
        self.aboutMeContainer.setNewAppNameString("About Me")
        self.aboutMeContainer.setCircularIcon(true)
        self.aboutMeContainer.button.tag = 10
        self.aboutMeContainer.button.addTarget(self, action: "appButtonSelected:", forControlEvents: UIControlEvents.TouchUpInside)
        self.scrollView?.addSubview(self.aboutMeContainer!)
        
        //coletaTri app
        self.coletaTri = AppView(frame: CGRectMake(Utils.WIDTH(self.view)*2, originX+50*2, Utils.WIDTH(self.view), height))
        self.coletaTri.backgroundColor = UIColor.clearColor()
        self.coletaTri.setNewAppIconImage( UIImage(named: "coletaTri-60.png")!)
        self.coletaTri.setNewAppNameString( "ColetaTri")
        self.coletaTri.button.addTarget(self, action: "appButtonSelected:", forControlEvents: UIControlEvents.TouchUpInside)
        self.coletaTri.button.tag = 0
        self.scrollView?.addSubview(self.coletaTri!)
        
        //speakUp
        self.speakUp = AppView(frame: CGRectMake(Utils.WIDTH(self.view)*2, originX+60*3, Utils.WIDTH(self.view), height))
        self.speakUp.backgroundColor = UIColor.clearColor()
        self.speakUp.setNewAppIconImage(UIImage(named:"speakUp-60.png")!)
        self.speakUp.setNewAppNameString("SpeakUp")
        self.speakUp.button.addTarget(self, action: "appButtonSelected:", forControlEvents: UIControlEvents.TouchUpInside)
        self.speakUp.button.tag = 1
        self.scrollView?.addSubview(self.speakUp!)
        
        //radioOabrs
        self.radioOabrs =  AppView(frame: CGRectMake(Utils.WIDTH(self.view)*2, originX+65*4, Utils.WIDTH(self.view), height))
        self.radioOabrs.backgroundColor = UIColor.clearColor()
        self.radioOabrs.setNewAppIconImage(UIImage(named: "radioOabrs-60.png")!)
        self.radioOabrs.setNewAppNameString("RádioOabrs")
        self.radioOabrs.button.addTarget(self, action: "appButtonSelected:", forControlEvents: UIControlEvents.TouchUpInside)
        self.radioOabrs.button.tag = 2
        self.scrollView?.addSubview(self.radioOabrs!)
    }
    
    func animateScrollViewPageOne(){
        UIView.transitionWithView(
            self.backgroundImage!,
            duration: 0.38,
            options: UIViewAnimationOptions.TransitionCrossDissolve,
            animations: {
                self.backgroundImage?.image = UIImage(named: "background-Blurred.png")
            }, completion: { (finished: Bool) in
                self.snapProfileImageAndNameLabelToCenter()
                self.animateBioLabel()
                
            })
    }
    
    // UIScrollView
    func scrollViewDidScroll(scrollView: UIScrollView){
      self.animateSubviewsWithOffset(scrollView.contentOffset.x)
       
        if(scrollView.contentOffset.x == 0){
            self.resetAppsAnimation()
        }
        
        if(scrollView.contentOffset.x == 320){
            self.bounceAnimateApps()
        }
    }
    
    func animateSubviewsWithOffset(offset: CGFloat){
        let profileOffSet:CGFloat = 85 - offset
        self.profileImage.frame = CGRectMake(Utils.ORIGINx(self.profileImage), profileOffSet, Utils.WIDTH(self.profileImage), Utils.HEIGHT(self.profileImage))
        
        let nameOffSet:CGFloat = 246 - offset
        self.nameLabel.frame = CGRectMake(Utils.ORIGINx(self.nameLabel), nameOffSet, Utils.WIDTH(self.nameLabel), Utils.HEIGHT(self.nameLabel))
        
        let bioOffSet:CGFloat = 320 + offset
        self.bioLabel.frame = CGRectMake(Utils.ORIGINx(self.bioLabel), bioOffSet, Utils.WIDTH(self.bioLabel), Utils.HEIGHT(self.bioLabel))
        
        let arrowOffset:CGFloat = (Utils.HEIGHT(self.view)-24) + offset
        self.arrowIndicator.frame = CGRectMake(Utils.ORIGINx(self.arrowIndicator), arrowOffset, Utils.WIDTH(self.arrowIndicator), Utils.HEIGHT(self.arrowIndicator))
    }
    
    //UIKitDynamics
    func animateBioLabel(){
        UIView.animateWithDuration(0.72,
            delay: 0.50,
            usingSpringWithDamping: 0.62,
            initialSpringVelocity: 0.38,
            options: UIViewAnimationOptions.CurveLinear,
            animations: {
                self.bioLabel?.frame = CGRectMake(12, 320, Utils.WIDTH(self.bioLabel!), Utils.HEIGHT(self.bioLabel!))
            }, completion: { (finished: Bool) in
                UIView.animateWithDuration(0.82 as NSTimeInterval,
                    animations: {
                    self.arrowIndicator?.alpha = 1.0
                })
                self.scrollView?.scrollEnabled = true
                NSTimer.scheduledTimerWithTimeInterval(1.45, target: self, selector: "animateContinueArrow", userInfo: nil, repeats: true)
        })

    }
    
    func animateContinueArrow(){
        UIView.animateWithDuration(0.52,
            animations: {
                self.arrowIndicator?.frame = CGRectMake(Utils.WIDTH(self.view) - 50,
                    Utils.ORIGINy(self.arrowIndicator!), Utils.WIDTH(self.arrowIndicator!)
                        , Utils.HEIGHT(self.arrowIndicator!))
            }, completion: { (finished:Bool) in
                self.animateContinueArrowWithDelay()
        })
    }
    
    func animateContinueArrowWithDelay(){
        UIView.animateWithDuration(0.52,
            animations: {
                self.arrowIndicator?.frame = CGRectMake(Utils.WIDTH(self.view) - 20,
                    Utils.ORIGINy(self.arrowIndicator!), Utils.WIDTH(self.arrowIndicator!)
                    , Utils.HEIGHT(self.arrowIndicator!))
            }, completion: nil)
    }
    
    func resetAppsAnimation(){
        let height:CGFloat = 80
        self.aboutMeContainer.frame = CGRectMake(Utils.WIDTH(self.view)*2, 60, Utils.WIDTH(self.view), height)
        self.coletaTri.frame = CGRectMake(Utils.WIDTH(self.view)*2, 60+50*2, Utils.WIDTH(self.view), height)
        self.speakUp.frame = CGRectMake(Utils.WIDTH(self.view)*2, 60+60*3, Utils.WIDTH(self.view), height)
        self.radioOabrs.frame = CGRectMake(Utils.WIDTH(self.view)*2, 60+65*4, Utils.WIDTH(self.view), height)
    }
    
    func bounceAnimateApps(){
        self.animateContainerForView(self.aboutMeContainer, withDelay: 0.0)
        self.animateContainerForView(self.coletaTri, withDelay: 0.12)
        self.animateContainerForView(self.speakUp, withDelay: 0.24)
        self.animateContainerForView(self.radioOabrs, withDelay: 0.36)
    }
    
    func snapProfileImageAndNameLabelToCenter(){
        let profileSnap: UISnapBehavior = UISnapBehavior(item: self.profileImage!, snapToPoint: CGPointMake(self.view.center.x, 170))
        profileSnap.damping = 0.38
        self.animator?.addBehavior(profileSnap)
        
        let nameSnap: UISnapBehavior = UISnapBehavior(item: self.nameLabel!, snapToPoint: CGPointMake(self.view.center.x, 272))
        nameSnap.damping = 0.58
        self.animator?.addBehavior(nameSnap)
    }
    
    func animateContainerForView(viewContainer: UIView, withDelay delay:NSTimeInterval){
        UIView.animateWithDuration(0.48 as NSTimeInterval,
            delay: delay as NSTimeInterval,
            usingSpringWithDamping: 0.56,
            initialSpringVelocity: 0.38,
            options: UIViewAnimationOptions.allZeros,
            animations: {
                viewContainer.frame = CGRectMake(Utils.WIDTH(self.view), Utils.ORIGINy(viewContainer), Utils.WIDTH(viewContainer), Utils.HEIGHT(viewContainer))
            }, completion: nil)
    }
    
    func appButtonSelected(sender:AnyObject!)
    {
        let tag:NSInteger = (sender as! UIControl).tag
        if(tag == 10){//aboutMe
            var aboutDetailView: AboutDetailViewController = AboutDetailViewController()
            aboutDetailView.transitioningDelegate = self
            self.presentViewController(aboutDetailView, animated: true, completion: nil)
        }else{//about me
            var singleArray:NSArray = self.AppArray.objectAtIndex(tag) as! NSArray
            
            var detail = AppDetailViewController()
            detail.name = singleArray.objectAtIndex(0) as! String
            detail.icon = singleArray.objectAtIndex(1) as! String
            detail.descriptionApp = singleArray.objectAtIndex(2) as! String
            detail.screenshots = singleArray.objectAtIndex(3) as! String
            detail.identifier = singleArray.objectAtIndex(4) as! String
            detail.transitioningDelegate = self
            self.presentViewController(detail, animated: true, completion: nil)
        }
    }
    
    // UIVIewControllerTransitioningDelegate
    func animationControllerForPresentedController(presented: UIViewController,
        presentingController presenting: UIViewController,
        sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
            self.transictionManager?.presenting = true
            return self.transictionManager
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        self.transictionManager?.presenting = false
        return self.transictionManager
    }
    

}

