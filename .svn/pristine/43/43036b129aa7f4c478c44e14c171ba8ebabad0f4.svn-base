//
//  ZXLoginManager.swift
//  YDHYK
//
//  Created by 120v on 2017/11/2.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXLoginManager: NSObject {
    
    //MARK: - 启动登录
    class func requestForLaunchLogin(success:((_ success: Bool,_ status:Int,_ content: Dictionary<String,Any>) -> Void)?,failed:((_ status: Int,_ errMsg: String)->Void)?) {
        var dic: Dictionary<String,Any> = Dictionary.init()
        let telePhoneUUID: String = ZXDevice.zx_deviceUUID()
        if telePhoneUUID.count != 0 {
            dic["uuid"] = telePhoneUUID
        }
        
        if ZXUser.user.tel.count != 0 {
            dic["tel"] = ZXUser.user.tel
        }
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.User.login), params: dic, sign: false, method: .post) { (s, status, content, string, error) in
            if status == ZXAPI_SUCCESS {
                success?(s,status,content)
            }else{
                failed?(status,(error?.description)!)
            }
        }
    }
    
    //MARK: - 获取设备信息
    class func requestForEquipment() {
        var dic: Dictionary<String,Any> = Dictionary.init()
        dic["uuid"] = ZXDevice.zx_deviceUUID()
        dic["mobileSystemType"] = ZXDevice.zx_deviceSystem()
        dic["mobileSystemVersion"] = ZXDevice.zx_deviceVersion()
        dic["mobileModel"] = ZXDevice.zx_deviceType()
        if ZXDevice.zx_deviceToken().isEmpty == false {
           dic["deviceToken"] = ZXDevice.zx_deviceToken()
        }
        dic["packageName"] = ZXDevice.zx_getBundleId()
        dic["appVersion"] = ZXDevice.zx_getBundleVersion()
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.User.updateEquipmentInfo), params: dic, method: .post, completion: { (success, status, content, string, errMsg) in
        })
    }
    
    //MARK: - 更新会员位置
    class func requestForUpdateUserLocation() {
        ZXLocationUtils.shareInstance.checkCurrentLocation { (status, location) in
            if status == ZXCheckLocationStatus.success {
                var dic: Dictionary<String,Any> = Dictionary.init()
                if location?.coordinate.latitude != nil {
                    dic["latitude"] = location?.coordinate.latitude
                }
                if location?.coordinate.longitude != nil {
                    dic["longitude"] = location?.coordinate.longitude
                }
                ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.User.updatePosition), params: dic, method: .post, completion: { (success, status, content, string, errMsg) in
                })
            }
        }
    }
    
    //MARK: - 网络请求闪屏信息并保存
    class func requestForFlashScreen() {
        var dic: Dictionary<String,Any> = Dictionary.init()
        if ZXUser.user.sex != -1 {
            dic["sex"] = ZXUser.user.sex
        }
        if ZXUser.user.ageGroups != -1 {
            dic["ageGroups"] = ZXUser.user.ageGroups
        }
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.User.getFlashScreen), params: dic, method: .post, completion: { (success, status, content, string, errMsg) in
            
            if status == ZXAPI_SUCCESS {
                if let data = content["data"] as? Dictionary<String, Any> {
                    let model = ZXFlashModel.mj_object(withKeyValues: data)
                    if ((model?.attachFileStr) != nil) {
                        ZXUser.user.saveFlashImageURL((model?.attachFileStr)!)
                    }
                }else{
                    ZXUser.user.saveFlashImageURL("")
                }
            }
        })
    }
    
    //MARK: - 获取年龄段
    class func requestForGetAgeGroup(completion:((_ success:Bool,_ status: Int,_ content:Dictionary<String,Any>,_ string: String,_ errorMsg: String)->Void)?) {
        var dict: Dictionary<String,Any> = Dictionary.init()
        dict["type"] = "1"
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.User.getDictList), params: dict, method: .post) { (succ, code, content, str, errMsg) in
            completion?(succ, code, content, str, errMsg?.errorMessage ?? "未知错误")
        }
    }
}
