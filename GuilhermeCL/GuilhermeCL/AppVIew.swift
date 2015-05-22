//
//  AppVIew.swift
//  GuilhermeCL
//
//  Created by Guilherme Leite Colares on 4/15/15.
//  Copyright (c) 2015 Guilherme Leite Colares. All rights reserved.
//

//import Foundation
import UIKit;

class AppView: UIView {
    var button:UIButton!
    var appIconImage:UIImage!
    var appNameString:NSString!
    var circularIcon:Bool!
    var imageView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView = UIImageView(frame: CGRectMake(15, 10, 60, 60))
        self.imageView.backgroundColor = UIColor.clearColor()
        self.imageView.layer.cornerRadius = 12.65
        self.imageView.clipsToBounds = true
        self.addSubview(self.imageView!)
        
        self.button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        self.button.frame = CGRectMake(0, 10, 320, 60)
        self.button.backgroundColor = UIColor.clearColor()
        self.button.titleLabel?.font = Utils.normalFontWithSize(21.0)
        self.button.titleEdgeInsets = UIEdgeInsets(top: 1,left: 90,bottom: 0,right: 0)
        self.button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        self.button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        self.addSubview(self.button!)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNewAppIconImage(image:UIImage){
        self.imageView.image = image
    }
    
    func setNewAppNameString(string:String){
        self.button.setTitle(string, forState: UIControlState.Normal)
    }
    
    func setCircularIcon(circular:Bool){
        if circular {
            self.imageView.layer.cornerRadius = 30.0
        }else{
            self.imageView.layer.cornerRadius = 12.65
        }
    }
}