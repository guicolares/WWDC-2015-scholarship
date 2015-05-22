//
//  Utils.swift
//  GuilhermeCL
//
//  Created by Guilherme Leite Colares on 4/15/15.
//  Copyright (c) 2015 Guilherme Leite Colares. All rights reserved.
//

import Foundation
import UIKit

class Utils: NSObject{
    static func WIDTH(view:UIView) -> CGFloat{
        return view.frame.size.width
    }
    
    static func HEIGHT(view:UIView) -> CGFloat{
        return view.frame.size.height
    }
    
    static func ORIGINx(view:UIView) -> CGFloat{
        return view.frame.origin.x
    }
    
    static func ORIGINy(view:UIView) -> CGFloat{
        return view.frame.origin.y
    }
    
    static func KScreenHeight() -> CGFloat{
       return UIScreen.mainScreen().bounds.size.height
    }
    
    static func normalFontWithSize(size:CGFloat) -> (UIFont){
        return UIFont(name: "Avenir", size: size)!
    }
    
    static func lightFontWithSize(size: CGFloat) -> (UIFont){
        return UIFont(name: "Avenir-light", size: size)!
    }
    
    static func boldFontWithSize(size: CGFloat) -> (UIFont){
        return UIFont(name: "Avenir-Heavy", size: size)!
    }
    
    func italicsFontWithSize(size: CGFloat) -> (UIFont){
        return UIFont(name: "Avenir-LightOblique", size: size)!
    }
    
    static func heightForLabelWithText(text: NSString,  constraint: CGSize , font: UIFont) -> (CGFloat){
        var dict: NSMutableDictionary = NSMutableDictionary();
        dict.setObject(UIFont(name: font.fontName, size: font.pointSize)!, forKey:NSFontAttributeName)
        var labelHeight: CGRect = text.boundingRectWithSize(constraint, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: dict as [NSObject : AnyObject], context: nil)
        
        return labelHeight.size.height
        
    }
    
    static func widthForLabelWithText(text: NSString,  constraint: CGSize , font: UIFont) -> (CGFloat){
        var dict: NSMutableDictionary = NSMutableDictionary();
        dict.setObject(UIFont(name: font.fontName, size: font.pointSize)!, forKey:NSFontAttributeName)
        var labelHeight: CGRect = text.boundingRectWithSize(constraint, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: dict as [NSObject : AnyObject], context: nil)
        
        return labelHeight.size.width
    }
}






