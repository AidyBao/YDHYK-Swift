//
//  ZXUCCashCouponViewModel.swift
//  YDHYK
//
//  Created by screson on 2017/11/9.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// CashCouponModel
@objcMembers class ZXUCCashCouponModel: NSObject {
    var couponId = ""
    var fullMoney: Double = 0   /**订单满*/
    var couponMoney: Double = 0 /**金额*/
    /**使用药店名称*/
    //var drugstoreName//
    /**集团名称*/
    var couponGroupName = ""// 现金券是通用的，所以显示集团
    var drugstoreId = ""
    var useDate = ""        //已使用日期
    var beginDateStr = ""   //有效期结束日期
    var endDateStr = ""     //有效期结束日期
    var headPortraitStr = ""
    var isUseStr = ""
    var isUse = 1           //0未使用 1已使用

    /**到期时间描述*/
    var zx_expiredDesc: String {
        get {
            let dateList = endDateStr.components(separatedBy: " ")
            if let first = dateList.first {
                return "\(first)前使用"
            }
            return "无数据"
        }
    }
    
    var zx_couponDescription: String {
        get {
            if fullMoney <= 0 {
                let p = "\(couponMoney)".zx_priceString(false,true)
                return "\(p)元现金券"
            }
            let f = "\(fullMoney)".zx_priceString(false,true)
            let p = "\(couponMoney)".zx_priceString(false,true)
            return "满\(f)元减\(p)元券"
        }
    }
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["couponId": "id"]
    }
}

class ZXUCCashCouponViewModel: NSObject {
    static func list(isValid: Bool,
                     pageNum: Int,
                     pageSize: Int,
                     completion: ((_ success: Bool, _ code: Int, _ list: [ZXUCCashCouponModel]?, _ errorMsg: String) -> Void)?) {
        var dicP: Dictionary<String, Any> = [:]
        if isValid {
            dicP["isValid"] = "0" //后台接口反的
        } else {
            dicP["isValid"] = "1"
        }
        dicP["pageNum"] = (pageNum <= 0 ? 1 : pageNum)
        dicP["pageSize"] = (pageSize <= 0 ? ZX.PageSize : pageSize)
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Coupon.list), params: dicP, method: .post) { (success, code, obj, _, error) in
            if code == ZXAPI_SUCCESS {
                if let data = obj["data"] as? Dictionary<String, Any>,let listData = data["listData"] as? Array<Dictionary<String, Any>> {
                    var tList: Array<ZXUCCashCouponModel> = []
                    for d in listData {
                        if let coupon = ZXUCCashCouponModel.mj_object(withKeyValues: d) {
                            tList.append(coupon)
                        }
                    }
                    completion?(true,code,tList,"")
                } else {
                    completion?(true,code,nil,"无相关数据")
                }
            } else {
                completion?(false,code,nil,error?.errorMessage ?? "未知错误")
            }
        }
    }
    
    static func detail(couponId: String,
                       completion: ((_ success: Bool, _ code: Int, _ couponDetail: ZXUCCashCouponModel?, _ errorMsg: String) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Coupon.detail), params: ["couponId": couponId], method: .post) { (success, code, obj, _, error) in
            if code == ZXAPI_SUCCESS {
                if let data = obj["data"] as? Dictionary<String, Any> {
                    completion?(true,code,ZXUCCashCouponModel.mj_object(withKeyValues: data),"")
                } else {
                    completion?(true,code,nil,"无相关数据")
                }
            } else {
                completion?(false,code,nil,error?.errorMessage ?? "未知错误")
            }
        }
    }
}
