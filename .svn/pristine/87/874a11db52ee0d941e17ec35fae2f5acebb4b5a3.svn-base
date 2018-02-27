//
//  ZXUCMarkedDrugViewModel.swift
//  YDHYK
//
//  Created by screson on 2017/11/9.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

@objcMembers class ZXUCMarkedDrugModel: NSObject {
    var markId = ""
    var drugstoreId = ""
    var drugstoreName = ""
    var drugId = ""
    var drugName = ""       //药品名称
    var packingSpec = ""    //包装规格
    var price: Double = 0   //单价
    var priceStr = ""       //处理后价格
    var attachFilesStr = "" //商品图片
    var approvalNumber = ""
    var isPrescription: Int = 0
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["markId": "id"]
    }
}

class ZXUCMarkedDrugViewModel: NSObject {
    static func list(completion: ((_ success: Bool, _ code: Int, _ list: [ZXUCMarkedDrugModel]?, _ errorMsg: String) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.MarkedDrug.list), params: nil, method: .post) { (s, c, obj, _, error) in
            if c == ZXAPI_SUCCESS {
                if let dList = obj["data"] as? Array<Dictionary<String,Any>> {
                    var list: Array<ZXUCMarkedDrugModel> = []
                    for d in dList {
                        if let model = ZXUCMarkedDrugModel.mj_object(withKeyValues: d) {
                            list.append(model)
                        }
                    }
                    completion?(true, c, list, "")
                } else {
                    completion?(true, c, nil, "无相关数据")
                }
            } else {
                completion?(false, c, nil, error?.errorMessage ?? "未知错误")
            }
        }
    }
    
    static func delete(with markId:String, completion: ((_ success: Bool,_ errorMsg: String) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.MarkedDrug.delete), params: ["memberCollectionId": markId], method: .post) { (s, c, obj, _, error) in
            if c == ZXAPI_SUCCESS {
                completion?(true, "")
            } else {
                if c != ZXAPI_LOGIN_INVALID {
                    completion?(false, error?.errorMessage ?? "未知错误")
                }
            }
        }
    }
}
