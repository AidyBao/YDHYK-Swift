//
//  ZXUIViewController.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/4/20.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXUIViewController: UIViewController {
    var preferredCartButtonHidden: Bool { return true }
    var onceLoad = false
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.zx_clearNavbarBackButtonTitle()
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.zx_clearNavbarBackButtonTitle()
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.zx_subTintColor
        ZXStoreRootViewController.cartButton.hide()
//        if let navBar = self.navigationController?.navigationBar {
//            navBar.layer.shadowRadius = 1
//            navBar.layer.shadowColor = UIColor.black.cgColor
//            navBar.layer.shadowOpacity = 0.3
//            navBar.layer.shadowOffset = CGSize(width: 0, height: 1)
//            navBar.layer.shadowPath = UIBezierPath(rect: navBar.bounds).cgPath
//        }
    }
    
    func loadOrderStatusUpdateNotice() {
        NotificationCenter.default.addObserver(self, selector: #selector(zx_refresh), name: ZXNotification.Order.update.zx_noticeName(), object: nil)
    }
    
    func showNavBarShadow(_ show:Bool) {
        if let navBar = self.navigationController?.navigationBar {
            if show {
                navBar.layer.shadowColor = UIColor.black.cgColor
            } else {
                navBar.layer.shadowColor = UIColor.clear.cgColor
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if preferredCartButtonHidden {
            ZXStoreRootViewController.cartButton.hide()
        } else {
            ZXStoreRootViewController.cartButton.show()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        ZXStoreRootViewController.cartButton.hide()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ZXRouter.checkLastCacheRemoteNotice()
    }
    
    override open var prefersStatusBarHidden: Bool {
        return false
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override var shouldAutorotate: Bool { return false }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { return .portrait }

}

