//
//  ZXNearbyController.swift
//  YDHYK
//
//  Created by 120v on 2017/11/15.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXNearbyController: NSObject {
    class func requestForPharmacyList(completion:((_ success:Bool,_ status: Int,_ cont: Dictionary<String,Any>,_ string: String ,_ errMessge: String)->Void)?) {
        ZXLocationUtils.shareInstance.checkCurrentLocation { (status, location) in
            if status == ZXCheckLocationStatus.success {
                ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Nearby.nearbyDrugstore), params: ["latitude":location?.coordinate.latitude ?? 0,"longitude":location?.coordinate.longitude ?? 0], method: .post) { (succ, code, content, str, errMsg) in
                    completion!(succ,code,content,str,errMsg?.errorMessage ?? "未知错误")
                }
            }
        }
    }
    
    class func joinMemberSuccess(_ objc: Notification,completion:((_ model: ZXSearchModel)-> Void)?) {
        if ((objc.object as? Dictionary<String,Any>) != nil) {
            let dict = objc.object as! Dictionary<String,Any>
            let storeId = dict["storeId"] as! String
            let model: ZXSearchModel = ZXSearchModel.findFirst(byCriteria: "WHERE storeId = \(storeId)")
            if model.isMember == 0 {
                model.isMember = 1
                model.update()
            }
            completion!(model)
        }
    }
}
