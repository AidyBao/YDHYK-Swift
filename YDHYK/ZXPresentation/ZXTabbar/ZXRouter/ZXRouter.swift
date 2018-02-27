//
//  ZXRouter.swift
//  ZXStructs
//
//  Created by JuanFelix on 2017/4/7.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXRouter: NSObject {
    class func changeRootViewController(_ rootVC:UIViewController!){
        ZXRootController.appWindow()?.rootViewController = rootVC
    }
    
    class func tabbarSelect(at index:Int) {
        if let tabbar = ZXRootController.zx_tabbarVC() {
            tabbar.selectedIndex = index
        }
    }
    
    class func tabbarShouldSelected(at index:Int) {
        if let tabbar = ZXRootController.zx_tabbarVC(),tabbar.delegate != nil {
            guard let controller = tabbar.viewControllers?[index] else {
                return
            }
            let _ = tabbar.delegate?.tabBarController!(tabbar, shouldSelect: controller)
        }
    }
    
    static func zx_backToHomePage() {
        ZXRouter.tabbarSelect(at: 0)
        ZXRootController.zx_nav(at: 1).popToRootViewController(animated: true)
        ZXRootController.zx_nav(at: 2).popToRootViewController(animated: true)
        ZXRootController.zx_nav(at: 3).popToRootViewController(animated: true)
    }
}
