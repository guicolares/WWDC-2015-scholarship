//
//  AboutDetailViewController.swift
//  GuilhermeCL
//
//  Created by Guilherme Leite Colares on 4/16/15.
//  Copyright (c) 2015 Guilherme Leite Colares. All rights reserved.
//

import UIKit

class AboutDetailViewController: UIViewController, UIScrollViewDelegate {
    var scrollView: UIScrollView!
    var arrowIndicator: UIImageView!
    let telephone:String! = "+55 (51) 9338-9959"
    let email:String! = "guicolares@gmail.com"
    let gitHubLink:String! = "https://github.com/guicolares"
    let linkdinLink:String! = "https://br.linkedin.com/in/guilhermecolares"
    
    var lblTitle:UILabel!
    var lblDuration:UILabel!
    var lblDescription:UILabel!
    var nextButton:UIButton = UIButton()
    var previousButton:UIButton = UIButton()
    var experienceShowing = 0;
    
    let experienceData = [
        [
            "IOS Developer Student @ BEPID",
            "Feb/2015 - Present",
            "Student at BEPiD (Brazilian Educational Program for iOS Developers), an innovative program to qualify graduation students on iOS development. The pedagogic approach used on this program is known as CBL (Challenged Based Learning), allowing students to learn in a collaborative way working together with students and teachers to solve challenges."
        ],
        [
            "Web Developer and Analyst @ OABRS",
            "May/2013 - Jan/2014",
            "Generate document analysis of future systems through interviews. Build diagrams, flowcharts, development of desktop applications, web, mobile, implementation and training to operators through lectures. Manage activities assignments for developers and pass the expectations of time to superiors."
        ],
        [
            "Developer Pleno @ DbServer",
            "Oct/2012 - May/2013",
            "Develop desktop and web applications to the Federal Court in relation to electronic processes systems (Eproc) and EDM (Electronic Document Management). Focus on scrum, webservices, unit testing and back-end."
        ],
        [
            "Web Developer @ GoiaNetworks",
            "Sept/2011 - Oct/2012",
            "Develop web applications such as social networks. Manage database, group membership and leader."
        ]
    ]
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpBackgroundView()
        self.setUpInterface()
        self.setUpScrollViewPageAbout()
        self.setUpScrollViewPageExperience()
        self.setUpScrollViewPageEducation()
        self.setUpScrollViewPageTechinicalSkills()
        self.setUpScrollViewPageContact()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpBackgroundView() {
        var backgroundImage: UIImageView! = UIImageView(frame: self.view.bounds)
        backgroundImage.contentMode = UIViewContentMode.ScaleToFill
        backgroundImage.clipsToBounds = true
        backgroundImage.image = UIImage(named: "profile.jpg")
        self.view.addSubview(backgroundImage)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
           var image:UIImage! = backgroundImage.image!.applyMainViewEffect()
            dispatch_async(dispatch_get_main_queue(), {
                backgroundImage.image = image
            })
        })
    }
    
    func setUpInterface(){
        self.scrollView = UIScrollView(frame: CGRectMake(0, 0, Utils.WIDTH(self.view), Utils.KScreenHeight()))
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSizeMake(Utils.WIDTH(self.view), Utils.KScreenHeight()*5)
        self.scrollView.pagingEnabled = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.scrollView)
        
        var closeButton:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        closeButton.frame = CGRectMake(Utils.WIDTH(self.view)-64, 0, 64, 80)
        closeButton.setImage(UIImage(named: "ic_close.png"), forState: UIControlState.Normal)
        closeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0)
        closeButton.addTarget(self, action: Selector("swipeToDismiss"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(closeButton)
    }
    
    func setUpScrollViewPageAbout(){
        var imageView:UIImageView = UIImageView(frame: CGRectMake(0, 0, Utils.WIDTH(self.view), 160))
        imageView.image = UIImage(named: "about-top.png")
        self.scrollView.addSubview(imageView)
        
        let labelText:String = "My interests are Mobile development, Software Engineering and Agile methodologies. I strive to work in meanigful projects that can change people's lives, allowing me to contribute with my knowledge while also evolving as a professional."
        let labelHeight:CGFloat = Utils.heightForLabelWithText(labelText, constraint: CGSizeMake(Utils.WIDTH(self.view)-30, CGFloat(MAXFLOAT)), font: Utils.normalFontWithSize(16.0))
        
        var label:UILabel = UILabel(frame: CGRectMake(15, 175, Utils.WIDTH(self.view)-30, labelHeight))
        label.text = labelText
        label.font = Utils.normalFontWithSize(16.0)
        label.textColor = UIColor.whiteColor()
        label.numberOfLines = 0
        self.scrollView.addSubview(label)
        
        self.createArrowIndicator(101, frame: CGRectMake((Utils.WIDTH(self.view)-8)/2, Utils.HEIGHT(self.view)-24, 8, 12), pageY: 0)
    }
    
    func setUpScrollViewPageExperience(){
        let pageY:CGFloat = Utils.KScreenHeight()
        
        var imageView:UIImageView = UIImageView(frame: CGRectMake(0, pageY, Utils.WIDTH(self.view), 160))
        imageView.image = UIImage(named: "Experience-top.png")
        self.scrollView.addSubview(imageView)
        
        var yPos = pageY+175 + 15;

        self.lblTitle = UILabel(frame: CGRectMake(15, pageY+175, Utils.WIDTH(self.view)-30,20))
        self.lblTitle.numberOfLines = 0
        self.lblTitle.font = UIFont(name: "HelveticaNeue-Light" , size: 17)
        self.lblTitle.text = self.experienceData[self.experienceShowing][0]
        self.lblTitle.textColor = UIColor.whiteColor()
        self.scrollView.addSubview(self.lblTitle)
        
        yPos += 15
        self.lblDuration = UILabel(frame: CGRectMake(15, yPos, Utils.WIDTH(self.view)-30, 20))
        self.lblDuration.numberOfLines = 0
        self.lblDuration.font = UIFont(name: "HelveticaNeue-Light", size: 17)
        self.lblDuration.text = self.experienceData[self.experienceShowing][1]
        self.lblDuration.sizeToFit()
        self.lblDuration.textColor = UIColor.whiteColor()
        self.scrollView.addSubview(self.lblDuration)
        
        yPos += 20
        self.lblDescription = UILabel(frame: CGRectMake(15, yPos, Utils.WIDTH(self.view)-30, 400))
        self.lblDescription.numberOfLines = 0
        self.lblDescription.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        self.lblDescription.textAlignment = NSTextAlignment.Justified
        let lblVal:String = self.experienceData[self.experienceShowing][2]
        self.lblDescription.text = lblVal.stringByReplacingOccurrencesOfString("|", withString: "\n")
        self.lblDescription.sizeToFit()
        self.lblDescription.textColor = UIColor.whiteColor()
        self.scrollView.addSubview(self.lblDescription)
        
        self.nextButton.frame = CGRectMake(5, yPos+210, 64, 80)
        self.nextButton.setTitle("Next", forState: UIControlState.Normal)
        self.nextButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.nextButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        self.nextButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Disabled)
        self.nextButton.backgroundColor = UIColor.clearColor()
        self.nextButton.addTarget(self, action: Selector("nextExperience"), forControlEvents: UIControlEvents.TouchUpInside)
        self.scrollView.addSubview(self.nextButton)
        self.nextButton.enabled = false
        
        self.previousButton.frame = CGRectMake(Utils.WIDTH(self.view)-90, yPos+210, 70, 80)
        self.previousButton.setTitle("Previous", forState: UIControlState.Normal)
        self.previousButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.previousButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        self.previousButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Disabled)
        self.previousButton.backgroundColor = UIColor.clearColor()
        self.previousButton.addTarget(self, action: Selector("previusExperience"), forControlEvents: UIControlEvents.TouchUpInside)
        self.scrollView.addSubview(self.previousButton)
        
        self.createArrowIndicator(102, frame: CGRectMake((Utils.WIDTH(self.view)-8)/2, pageY+Utils.HEIGHT(self.view)-24, 8, 12), pageY:pageY)
    }
    
    func nextExperience(){
        if self.experienceShowing > 0 {
            self.experienceShowing--
            self.bounceAnimateExperience()
        }
        
        if self.experienceShowing == 0 {
            self.nextButton.enabled = false
        }else{
            self.nextButton.enabled = true
        }
        
        self.previousButton.enabled = true
    }
    
    func previusExperience(){
        if (self.experienceShowing+1) < self.experienceData.count {
            self.experienceShowing++
            self.bounceAnimateExperience()
        }
        
        if(self.experienceShowing+1) == self.experienceData.count {
            self.previousButton.enabled = false
        }else{
            self.previousButton.enabled = true
        }
        
        self.nextButton.enabled = true
    }
    
    func bounceAnimateExperience(){
        self.animateContainerForView(self.lblTitle,replaceText:self.experienceData[self.experienceShowing][0], withDelay: 0.0, yPos: -15)
        self.animateContainerForView(self.lblDuration,replaceText:self.experienceData[self.experienceShowing][1], withDelay: 0.0, yPos: 15)
        self.animateContainerForView(self.lblDescription,replaceText:self.experienceData[self.experienceShowing][2], withDelay: 0.0, yPos: 100)
    }
    
    func animateContainerForView(viewContainer: UILabel, replaceText:String ,withDelay delay:NSTimeInterval, yPos:CGFloat){
        let pageY:CGFloat = Utils.KScreenHeight()+yPos
        UIView.animateWithDuration(0.30 as NSTimeInterval,
            delay: 0.0,
            usingSpringWithDamping: 0.56,
            initialSpringVelocity: 0.38,
            options: UIViewAnimationOptions.allZeros,
            animations: {
                viewContainer.frame = CGRectMake(Utils.WIDTH(self.view)*(-1), pageY, Utils.WIDTH(self.view)-30,400)
            }, completion: { (finished:Bool) in
                viewContainer.frame = CGRectMake(Utils.WIDTH(self.view), pageY, Utils.WIDTH(self.view)-30,400)
                viewContainer.text = replaceText.stringByReplacingOccurrencesOfString("|", withString: "\n")

                UIView.animateWithDuration(0.30 as NSTimeInterval,
                    delay: delay as NSTimeInterval,
                    usingSpringWithDamping: 0.56,
                    initialSpringVelocity: 0.38,
                    options: UIViewAnimationOptions.allZeros,
                    animations: {
                        viewContainer.frame = CGRectMake(15, pageY, Utils.WIDTH(self.view)-30,400)
                    }, completion: nil)
        })
    }
    
    func setUpScrollViewPageEducation(){
        let pageY:CGFloat = Utils.KScreenHeight()*2
        
        var imageView:UIImageView = UIImageView(frame: CGRectMake(0, pageY, Utils.WIDTH(self.view), 160))
        imageView.image = UIImage(named: "education-top.png")
        self.scrollView.addSubview(imageView)
        
        let labelText:String = "-Analyst and Developing Systems\nFAQI. (5th semester)\n-English Course Advanced\n Cultura Inglesa. (5th semester)\n-Android Development Advanced\n TargetTrust(2014) 40 hours\n-Android Development Basic.\n TargetTrust(2014) 60 hours\n-Software Testing\nPUCRS(2013) 30 hours\n-Techinical School\nQI(2010) 1051 hours"
        let labelHeight:CGFloat = Utils.heightForLabelWithText(labelText, constraint: CGSizeMake(Utils.WIDTH(self.view)-30, CGFloat(MAXFLOAT)), font: Utils.normalFontWithSize(16.0))
        
        var label:UILabel = UILabel(frame: CGRectMake(15, pageY+175, Utils.WIDTH(self.view)-30, labelHeight))
        label.text = labelText
        label.font = Utils.normalFontWithSize(16.0)
        label.textColor = UIColor.whiteColor()
        label.numberOfLines = 0
        self.scrollView.addSubview(label)
        
        self.createArrowIndicator(102, frame: CGRectMake((Utils.WIDTH(self.view)-8)/2, pageY+Utils.HEIGHT(self.view)-24, 8, 12), pageY:pageY)
    }
    
    func setUpScrollViewPageTechinicalSkills(){
        let pageY:CGFloat = Utils.KScreenHeight()*3
        
        var imageView:UIImageView = UIImageView(frame: CGRectMake(0, pageY, Utils.WIDTH(self.view), 160))
        imageView.image = UIImage(named: "techinical_skills-top.png")
        self.scrollView.addSubview(imageView)
        
        let labelText:String = "Experience in programming languages such as Objective-C, Swift, Java, PHP, Javascript, Pascal.\nKnowledge in programming language such as C/C++, Python.\nExperience in Software Enginieering, Design Patterns and Software Archicture.\nExperience in Modeling Relational Databases, SQL, PL/SQL, SQLServer, Ingress.\nExperience in Agile Software Development methodologies such as Scrum and XP."
        let labelHeight:CGFloat = Utils.heightForLabelWithText(labelText, constraint: CGSizeMake(Utils.WIDTH(self.view)-30, CGFloat(MAXFLOAT)), font: Utils.normalFontWithSize(16.0))
        
        var label:UILabel = UILabel(frame: CGRectMake(15, pageY+175, Utils.WIDTH(self.view)-30, labelHeight))
        label.text = labelText
        label.font = Utils.normalFontWithSize(16.0)
        label.textColor = UIColor.whiteColor()
        label.numberOfLines = 0
        self.scrollView.addSubview(label)
        
        self.createArrowIndicator(102, frame: CGRectMake((Utils.WIDTH(self.view)-8)/2, pageY+Utils.HEIGHT(self.view)-24, 8, 12), pageY:pageY)
    }
    
    func setUpScrollViewPageContact(){
        let pageY:CGFloat = Utils.KScreenHeight()*4
        
        var imageView:UIImageView = UIImageView(frame: CGRectMake(0, pageY, Utils.WIDTH(self.view), 160))
        imageView.image = UIImage(named: "contact-top.png")
        self.scrollView.addSubview(imageView)
        
        var labelHeight:CGFloat = Utils.heightForLabelWithText(self.email, constraint: CGSizeMake(Utils.WIDTH(self.view)-30, CGFloat(MAXFLOAT)), font: Utils.normalFontWithSize(16.0))
        
        var buttonEmail:UIButton = UIButton(frame: CGRectMake(15, pageY+175, Utils.WIDTH(self.view)-30, labelHeight))
        buttonEmail.setTitle(self.email, forState:UIControlState.Normal)
        buttonEmail.sizeToFit()
        buttonEmail.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        buttonEmail.addTarget(self, action: "sendEmail", forControlEvents: UIControlEvents.TouchUpInside)
        self.scrollView.addSubview(buttonEmail)
       
        labelHeight = Utils.heightForLabelWithText(self.telephone, constraint: CGSizeMake(Utils.WIDTH(self.view)-30, CGFloat(MAXFLOAT)), font: Utils.normalFontWithSize(16.0))
        var buttonTelephone:UIButton = UIButton(frame: CGRectMake(15, pageY+220, Utils.WIDTH(self.view)-30, labelHeight))
        buttonTelephone.setTitle(self.telephone, forState: UIControlState.Normal)
        buttonTelephone.sizeToFit()
        buttonTelephone.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        buttonTelephone.addTarget(self, action: "callMe", forControlEvents: UIControlEvents.TouchUpInside)
        self.scrollView.addSubview(buttonTelephone)
       
        labelHeight = Utils.heightForLabelWithText("Linkdin", constraint: CGSizeMake(Utils.WIDTH(self.view)-30, CGFloat(MAXFLOAT)), font: Utils.normalFontWithSize(16.0))
        var buttonLinkdin:UIButton = UIButton(frame: CGRectMake(15, pageY+265, Utils.WIDTH(self.view)-30, labelHeight))
        buttonLinkdin.setTitle("Linkdin", forState: UIControlState.Normal)
        buttonLinkdin.sizeToFit()
        buttonLinkdin.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        buttonLinkdin.addTarget(self, action: "openLinkdin", forControlEvents: UIControlEvents.TouchUpInside)
        self.scrollView.addSubview(buttonLinkdin)
        
        labelHeight = Utils.heightForLabelWithText("Github", constraint: CGSizeMake(Utils.WIDTH(self.view)-30, CGFloat(MAXFLOAT)), font: Utils.normalFontWithSize(16.0))
        var buttonGitHub:UIButton = UIButton(frame: CGRectMake(15, pageY+310, Utils.WIDTH(self.view)-30, labelHeight))
        buttonGitHub.setTitle("Github", forState: UIControlState.Normal)
        buttonGitHub.sizeToFit()
        buttonGitHub.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        buttonGitHub.addTarget(self, action: "openGithub", forControlEvents: UIControlEvents.TouchUpInside)
        self.scrollView.addSubview(buttonGitHub)
    }
    
    func sendEmail(){
        UIApplication.sharedApplication().openURL(NSURL(string: ("mailto://"+self.email))!)
    }
    
    func callMe(){
        var phone = self.telephone.stringByReplacingOccurrencesOfString(" ", withString: "")
        UIApplication.sharedApplication().openURL(NSURL(string: ("tel://"+phone))!)
    }
    
    func openLinkdin(){
        UIApplication.sharedApplication().openURL(NSURL(string: self.linkdinLink)!)
    }
    
    func openGithub(){
        UIApplication.sharedApplication().openURL(NSURL(string: self.gitHubLink)!)
    }
    
    func createArrowIndicator(tag:Int, frame:CGRect, pageY:CGFloat ){
        var arrowIndicator: UIImageView = UIImageView(frame: frame)
        arrowIndicator.image = UIImage(named: "ic_arrow.png")
        arrowIndicator.transform = CGAffineTransformMakeRotation(CGFloat((M_PI*90)/180))
        arrowIndicator.tag = tag
        self.scrollView.addSubview(arrowIndicator)
        
        var userInfo =  ["pageY": pageY, "arrowIndicatior": arrowIndicator]
        NSTimer.scheduledTimerWithTimeInterval(1.50, target: self, selector: "animateContinueArrow:", userInfo: userInfo, repeats: true)
    }
    
    func animateContinueArrow(timer:NSTimer){
        let userInfo:NSDictionary = timer.userInfo as! NSDictionary
        var arrowIndicator = userInfo["arrowIndicatior"] as! UIImageView
        var pageY:CGFloat = userInfo["pageY"] as! CGFloat
      
        UIView.animateWithDuration(0.52,
            animations: {
                arrowIndicator.frame = CGRectMake((Utils.WIDTH(self.view)-8)/2,
                    pageY+Utils.HEIGHT(self.view)-35, Utils.WIDTH(arrowIndicator)
                    , Utils.HEIGHT(arrowIndicator))
            }, completion: { (finished:Bool) in
                self.animateContinueArrowWithDelay(pageY, arrowIndicator: arrowIndicator)
        })
    }

    func animateContinueArrowWithDelay(pageY:CGFloat, arrowIndicator: UIImageView){
        UIView.animateWithDuration(0.52,
            animations: {
                arrowIndicator.frame = CGRectMake((Utils.WIDTH(self.view)-8)/2, pageY+Utils.HEIGHT(self.view)-24, Utils.WIDTH(arrowIndicator)
                    , Utils.HEIGHT(arrowIndicator))
            }, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func swipeToDismiss(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
