//
//  AppDelegate.swift
//  YDHYK
//
//  Created by screson on 2017/11/1.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
import MJRefresh
import MJExtension
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isProcessed: Bool = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        isProcessed = true
        //Load-Config
        ZXStructs.loadUIConfig()
        //Init VC
        ZXRootController.zxReload()
        //Set RootVC
//        ZXRouter.changeRootViewController(ZXRootController.zx_tabbarVC())
        ZXRouter.changeRootViewController(ZXLaunchRootViewController())
        //BMap
        launchBaiBuMap()
        //Location
        getCurrentLocation()
        
        #if DEBUG
            ZXNetwork.showRequestLog = true
        #endif
        
        self.zx_addNotice()
        ZXStoreRootViewController.cartButton.delegate = self
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        ZXUser.user.sync()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        ZXUser.user.sync()
        ZXGlobalData.enterBackground()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
        ZXGlobalData.enterForeground()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        self.judgmentLocationServiceEnabled()
        
        self.checkRemoteNoticeStatus()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        ZXUser.user.sync()
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}

extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return UITabBarController.zx_tabBarController(tabBarController, shouldSelectViewController: viewController)
    }
}

extension AppDelegate {
    func getCurrentLocation() {
        ZXLocationUtils.shareInstance.checkCurrentLocation { (status, location) in
            print(status,location?.coordinate.latitude ?? 0)
            if status == ZXCheckLocationStatus.success {
                
            }else{
                
            }
        }
    }
}

