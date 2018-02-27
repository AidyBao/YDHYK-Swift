//
//  ZXUCOrderControlActionProtocol.swift
//  YDHYK
//
//  Created by screson on 2017/11/7.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

enum ZXOrderControlType {
    case toPay          //立即付款
    case reviewCode     //查看提货码
    case confirmSign    //确认收货
    case cancel         //取消订单
    case delete         //删除订单
    case none
    
    func description() -> String {
        switch self {
            case .toPay:
                return "立即付款"
            case .reviewCode:
                return "查看提货码"
            case .confirmSign:
                return "确认收货"
            case .cancel:
                return "取消订单"
            case .delete:
                return "删除订单"
            default:
                return "无操作"
        }
    }
}

protocol ZXUCOrderControlActionDelegate: class {
    func zxUCOrderControlerAction(with type: ZXOrderControlType,cell : UITableViewCell)
}
