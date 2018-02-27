//
//  ZXUCOrderType.swift
//  YDHYK
//
//  Created by screson on 2017/11/6.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 订单状态
enum ZXUCOrderStatus: UInt {
    case invalid        =   0   /*已作废*/
    case waitDispatch   =   1   /*待发货*/
    case waitPay        =   2   /*待支付*/
    case dispatched             /*已发货-UI待收货*/
    case waitTake               /*待取货-自提*/
    case refunding              /*退款中 暂无*/
    case canceled               /*已关闭 - UI已取消*/
    case finished               /*已完成*/
    case preparing              /*备货中*/
    case all                    /*全部订单*/
    
    func description() -> String {
        switch self {
            case .invalid:
                return "已作废"
            case .waitDispatch:
                return "待发货"
            case .waitPay:
                return "待付款"
            case .dispatched:
                return "待收货"
            case .waitTake:
                return "待提货"
            case .refunding:
                return "退款中"
            case .canceled:
                return "已取消"
            case .finished:
                return "已完成"
            case .preparing:
                return "待备货"
            case .all:
                return "全部订单"
        }
    }
}

enum ZXUCOrderReceivingType: UInt {
    case express        =   1   /*送货上门*/
    case selfTake       =   2   /*到店自提*/
    case all
    func description() -> String {
        switch self {
            case .express:
                return "送货上门"
            case .selfTake:
                return "到店自提"
            default:
                return ""
        }
    }
}
