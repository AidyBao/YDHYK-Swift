//
//  ZXOrderCouponModel.swift
//  YDHYK
//
//  Created by screson on 2017/10/27.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

@objcMembers class ZXOrderCouponModel: NSObject {
    var couponId = ""
    var code = ""
    var fullMoney: Double = 0   //满减 阈值
    var couponMoney: Double = 0 //现金券金额
    var groupName = ""      // 现金券 显示集团
    var drugstoreIdNow = "" //店铺Id
    var useDate = ""        //已使用日期
    var beginDateStr = ""   //有效期开始日期
    var endDateStr = ""     //有效期结束日期
    var headPortraitStr = ""
    var isUseStr = ""
    var isUse = 0           //0未使用 1已使用
    
    var zx_isSelected = false
    var zx_valid = true
    //调整
    var url: URL? {
        get {
            return URL.init(string: headPortraitStr)
        }
    }
    
    var zx_expiredDesc: String {
        get {
            let arr = endDateStr.components(separatedBy: " ")
            if let date = arr.first {
                return "\(date)前使用"
            }
            return ""
        }
    }
    
    var zx_valueInfo: String {
        get {
            return "\(couponMoney)".zx_priceString(true, true) + " 优惠券"
        }
    }
    
    var zx_couponDescription: String {
        get {
//            if fullMoney <= 0 {
//                return "\(Int(couponMoney))元现金券"
//            }
//            return "满\(Int(fullMoney))元减\(Int(couponMoney))元券"
            if fullMoney <= 0 {
                return "直接抵扣"
            }
            return "满\(Int(fullMoney))元可用"
        }
        
    }
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["couponId":"id"]
    }
}
