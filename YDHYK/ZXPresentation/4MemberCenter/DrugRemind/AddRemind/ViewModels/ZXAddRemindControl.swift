//
//  ZXAddRemindControl.swift
//  YDHYK
//
//  Created by 120v on 2017/11/28.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXAddRemindControl: NSObject {
    
    //MARK: - 用药提醒历史订单药品列表
    class func requestForGetHistoryDrugOrder(completion:@escaping (_ succ:Bool, _ code: Int,_ orderArr:Array<ZXHistoryOrderModel>?)->Void) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.UseDrug.historyDrugOrder), params: Dictionary.init(), method: .post) { (succes, code, content, string, errMsg) in
            if succes {
                if let data = content["data"] as? Array<Any>,data.count > 0 {
                    let orderArray = ZXHistoryOrderModel.mj_objectArray(withKeyValuesArray: data)
                    completion(true,code,orderArray as? Array<ZXHistoryOrderModel>)
                }else{
                    completion(false,code,nil)
                }
            }else{
                completion(false,code,nil)
            }
        }
    }
    
    //MARK: - 获取用药单位
    class func requestForGetDrugUnits(_ type: String,completion:@escaping (_ succ:Bool, _ code: Int,_ orderArr:Array<ZXCommonModel>?)->Void) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Common.dicList), params: ["type":type], method: .post) { (succes, code, content, string, errMsg) in
            if succes {
                if let data = content["data"] as? Array<Any>,data.count > 0 {
                    let dictList = ZXCommonModel.mj_objectArray(withKeyValuesArray: data)
                    completion(true,code,dictList as? Array<ZXCommonModel>)
                }else{
                    completion(false,code,nil)
                }
            }else{
                completion(false,code,nil)
            }
        }
    }
    
    //MARK: - 添加用药提醒
    class func requestForAddDrugRemind(_ param: Dictionary<String,Any>,completion:@escaping (_ succ:Bool, _ code: Int,_ errMsg: String?)->Void) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.UseDrug.addRemind), params: param, method: .post) { (succes, code, content, string, errMsg) in
            if succes {
                if code == ZXAPI_SUCCESS {
                    completion(true,code,errMsg?.errorMessage)
                }else{
                    completion(false,code,errMsg?.errorMessage)
                }
            }else{
                completion(false,code,errMsg?.errorMessage)
            }
        }
    }
}
