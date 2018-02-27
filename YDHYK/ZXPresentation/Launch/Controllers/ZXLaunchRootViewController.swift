//
//  ZXLaunchRootViewController.swift
//  YDHYK
//
//  Created by 120v on 2017/11/2.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXLaunchRootViewController: ZXUIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //获取用户数据
        ZXUser.user.getUser()

        rejudgeLoginStatus()
    }
    
    
    
    func rejudgeLoginStatus() {
        if ZXUser.user.isLogin {
            requestForLogin()
        }else{
            changeRootController()
        }
    }
    
    func requestForLogin() {
        ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: nil)
        ZXLoginManager.requestForLaunchLogin(success: { (s, code, content) in
            if code == ZXAPI_SUCCESS {
                ZXHUD.hide(for: self.view, animated: true)
                if let objc = content["data"] as? Dictionary<String,Any>{
                    
                    self.saveUserInfo(objc)
                ZXRouter.changeRootViewController(ZXFlashScreenViewController())
                    
                    //MARK: - getArea
                    DispatchQueue.global().async {
                        ZXEditProfileController.requestForGetArea { (array) in }
                    }
                }
            }
        }) { (code, errMsg) in
            
            ZXUser.user.invalid()
            
            self.changeRootController()
        }
    }
    
    func saveUserInfo(_ dict: Dictionary<String,Any>) {
        ZXUser.user.save(dict)
    }
    
    func changeRootController() {
       
        let navVC: UINavigationController = UINavigationController.init(rootViewController: ZXLoginRootViewController())
        navVC.navigationController?.isNavigationBarHidden = true
        ZXRouter.changeRootViewController(navVC)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override open var prefersStatusBarHidden: Bool {
        return false
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
}
