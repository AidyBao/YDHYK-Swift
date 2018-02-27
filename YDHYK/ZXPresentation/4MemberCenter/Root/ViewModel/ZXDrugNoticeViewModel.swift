//
//  ZXDrugNoticeViewModel.swift
//  YDHYK
//
//  Created by screson on 2017/11/15.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

@objcMembers class ZXTakeMedicineModel: NSObject {
    var drugName = ""   //药品名称
    var dosage:Int = 0  //用量
    var unit = ""       //单位
    var notes = ""      //备注
    var detailId = ""
    
    var zx_dosageDesc: String {
        return "\(dosage)\(unit)"
    }
}

class ZXDrugNoticeViewModel: NSObject {
    
    /// 稍后提醒
    /// 不处理异常情况
    /// - Parameter ids: ids 多个id逗号分隔
    static func remindLater(ids: String) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.RemoteNotice.remindLater), params: ["detailIds": ids], method: .post) { (_, _, _, _, _) in
            
        }
    }
    
    /// 通过用药提醒获取用药列表
    ///
    /// - Parameters:
    ///   - remindIds: 提醒id 多个id逗号分隔
    ///   - deailTime: 用药时间
    ///   - completion:
    static func getMedicineList(remindIds: String,
                                deailTime: String,
                                completion:((_ code:Int,_ list:[ZXTakeMedicineModel]?) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.RemoteNotice.remindList), params: ["remindIds": remindIds,"remindDetailTime": deailTime], method: .post) { (success, code, obj, _, error) in
            if code == ZXAPI_SUCCESS {
                if let data = obj["data"] as? Array<Dictionary<String,Any>> {
                    var list: Array<ZXTakeMedicineModel> = []
                    for d in data {
                        if let m = ZXTakeMedicineModel.mj_object(withKeyValues: d) {
                            list.append(m)
                        }
                    }
                    completion?(code, list)
                } else {
                    completion?(code, nil)
                }
            } else {
                completion?(code, nil)
            }
        }
    }
}
