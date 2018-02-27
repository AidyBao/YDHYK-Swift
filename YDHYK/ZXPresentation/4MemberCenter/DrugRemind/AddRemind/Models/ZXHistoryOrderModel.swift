//
//  ZXHistoryOrderModel.swift
//  YDHYK
//
//  Created by 120v on 2017/11/28.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

@objcMembers class ZXHistoryOrderModel: NSObject {
    var address: String         = ""
    var closeReason: String     = ""
    var consignee: String       = ""
    var couponCode: String      = ""
    var couponId: Int           = -1
    var couponMoney: String     = ""
    var discountTotal: Int      = 0
    var drugstoreId: Int        = -1
    var drugstoreName: String   = ""
    var drugstoreTel: String    = ""
    var expectDate: String      = ""
    var freight: String         = ""
    var groupId: Int            = -1
    var groupName: String       = ""
    var headPortrait: String    = ""
    var headPortraitStr: String = ""
    var orderId: Int              = -1
    var memberId: Int           = -1
    var operatorDate: String    = ""
    var operatorId: String      = ""
    var operatorName: String    = ""
    var orderDate: String       = ""
    var orderDateStr: String    = ""
    var orderDetailList: Array<Any> = []
    var orderNo: Int            = -1
    var originalPrice: String   = ""
    var payDate: String         = ""
    var payTotal: String        = ""
    var paymentMethod: String   = ""
    var paymentMethodStr: String   = ""
    var price: String           = ""
    var receiveType: String     = ""
    var drugTime: String        = ""
    var receiveTypeStr: String  = ""
    var remark: String          = ""
    var status: String          = ""
    var statusStr: String       = ""
    var tel: String             = ""
    var verificateCode: Int     = -1
    var addQty: Int             = 0
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["orderId":"id"]
    }
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["orderDetailList":ZXHistoryOrderDetailModel.self]
    }
}
