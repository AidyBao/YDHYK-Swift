//
//  ZXUCOrderDetailModel.swift
//  YDHYK
//
//  Created by screson on 2017/11/6.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 个人中心-订单列表Model
/// ZXUserCenterOrderListModel
@objcMembers class ZXUCOrderDetailModel: NSObject {
    
    var orderId = ""
    var drugstoreName = ""      //药店名称
    var drugstoreId = ""        //店铺wed id
    var drugstoreTel = ""       //店铺电话
    var headPortraitStr = ""    //药店Logo
    var statusStr = ""          //订单状态
    var status: UInt = 0        //0作废 1待发货 2待支付 3已发货 4待取货 5退款中 6已关闭 7已完成 8备货中
    var zx_status: ZXUCOrderStatus {
        get {
            if let s = ZXUCOrderStatus(rawValue: self.status) {
                return s
            }
            return .invalid
        }
    }
    //var payTotal
    var payTotalStr = ""        //实付金额
    var originalPriceStr = ""   //总金额
    var freight: Double = 0
    var couponMoney: Double = 0
    var orderDetailList: Array<ZXUCOrderDrugModel> = []
    //MARK:支付-提货 信息
    var receiveType: UInt = 2    //送货方式
    var zx_receiveType: ZXUCOrderReceivingType {
        get {
            if let type = ZXUCOrderReceivingType(rawValue: self.receiveType) {
                return type
            }
            return .all
        }
    }
    var consignee = ""          //收货人
    var tel = ""                //联系电话
    var address = ""            //地址
    var drugstoreAddress = ""   //店铺地址  自提订单显示
    var orderNo = ""            //订单编号
    var paymentMethodStr = ""   //支付方式
    var receiveTypeStr = ""     //配送方式
    var orderDateStr = ""       //下单时间 字符串
    var orderDate: Int64 = 0    //下单时间
    
    var drugNum: Int = 0 //订单总数
    
    //MAKR: - 调整
    var zx_expiredDateStr: String {
        let currentMillSeconds = ZXDateUtils.current.millisecond()
        let dis = currentMillSeconds - self.orderDate
        let hour = (dis / (60 * 60 * 1000))
        if hour <= 24 {
            return "请在\(hour)小时内完成支付,逾期系统会自动取消订单"
        }
        return "订单已超过有效支付时间"
    }//未支付订单过期描述 【默认24小时有效期】
    
    /// 订单总金额信息
    var zx_totalInfoAttributeStr: NSAttributedString {
        get {
            let strCount = "\(self.drugNum)"
            let strPrice = self.originalPriceStr.zx_priceString()
            let attrText = NSMutableAttributedString.init(string: "共")
            let attrCount = NSMutableAttributedString.init(string: strCount)
            attrCount.zx_appendFont(font: UIFont.zx_titleFont(16), at: NSMakeRange(0, strCount.count))
            attrText.append(attrCount)
            attrText.append(NSAttributedString.init(string: "件商品,合计"))
            let attrPrice = NSMutableAttributedString.init(string: strPrice)
            attrPrice.zx_appendFont(font: UIFont.zx_titleFont(16), at: NSMakeRange(0, strPrice.count))
            attrText.append(attrPrice)
            attrText.append(NSAttributedString.init(string: "元"))
            let strF = "\(self.freight)".zx_priceString(false)
            let strFreight = "(含运费\(strF)元)"
            let attrFreight = NSMutableAttributedString.init(string: strFreight)
            attrFreight.zx_appendFont(font: UIFont.zx_titleFont(11), at: NSMakeRange(0, strFreight.count))
            attrText.append(attrFreight)
            return attrText
        }
    }
    
    var zx_couponInfo: String {
        get {
            let couponStr = "\(couponMoney)".zx_priceString(false)
            return "现金券抵扣:\(couponStr)元"
        }
    }

    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["orderId": "id"]
    }
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["orderDetailList": ZXUCOrderDrugModel.self]
    }
}
