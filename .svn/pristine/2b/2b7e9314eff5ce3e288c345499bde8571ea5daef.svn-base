//
//  AppDelegate+BMap.swift
//  YDHYK
//
//  Created by 120v on 2017/11/1.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

var mapManager: BMKMapManager?

extension AppDelegate {
    
    func judgmentLocationServiceEnabled() {
        ZXLocationUtils.shareInstance.checkCurrentLocation { (status, location) in
            var isSuccess: Bool = false
            if status == .success {
                isSuccess = true
            }else{
                isSuccess = false
            }
            NotificationCenter.zxpost.judgementLocationStatus(isSuccess)
        }
    }

    func launchBaiBuMap() {
        var bmap_Key: String = ""
        
        if ZXDevice.zx_getBundleId() == ZX.Package.enterpriseBundleId{
            bmap_Key = ZX.BMap.Enterprise_Key
        }else{
            bmap_Key = ZX.BMap.AppStore_Key
        }
        mapManager = BMKMapManager.init()
        let ret: Bool = (mapManager?.start(bmap_Key, generalDelegate: self))!
        if !ret {
            print("manager start failed!")
        }
    }
}

extension AppDelegate: BMKGeneralDelegate {
    func onGetNetworkState(_ iError: Int32) {
        if 0 == iError {
            print("联网成功")
        }else{
            print("onGetNetworkState \(iError)")
        }
    }
    func onGetPermissionState(_ iError: Int32) {
        if 0 == iError {
            print("授权成功")
        }else{
            print("onGetPermissionState \(iError)")
        }
    }
}
