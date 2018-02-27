//
//  UIView+ZX.swift
//  rbstore
//
//  Created by 120v on 2017/7/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

extension UIView {

    public var x : CGFloat{
        get{
            return self.frame.origin.x
        }
        set(newView){
            self.frame.origin.x = newView
        }
    }
    
    public var y : CGFloat{
        get{
            return self.frame.origin.y
        }
        set(newView){
            self.frame.origin.y = newView
        }
    }
    
    public var width : CGFloat{
        get{
            return self.frame.size.width
        }
        set(newView){
            self.frame.size.width = newView
        }
    }
    
    public var height : CGFloat{
        get{
            return self.frame.size.height
        }
        set(newView){
            self.frame.size.height = newView
        }
    }
    
    public var centerX : CGFloat{
        get{
            return self.center.x
        }
        set(newView){
            self.center.x = newView
        }
    }
    
    public var centerY : CGFloat{
        get{
            return self.center.y
        }
        set(newView){
            self.center.y = newView
        }
    }
    
    public var right : CGFloat{
        get{
            return self.frame.maxX
        }
        set(newView){
            self.x = newView - self.width
        }
    }
    
    public var bottom : CGFloat{
        get{
            return self.frame.maxY
        }
        set(newView){
            self.y = newView - self.height
        }
    }
    
    public var size : CGSize{
        get{
            return self.frame.size
        }
        set(newView){
            self.frame.size = newView
        }
    }
}
