//
//  ZXNotification.swift
//  rbstore
//
//  Created by screson on 2017/7/12.
//  Copyright © 2017年 screson. All rights reserved.
//

import Foundation

class ZXNotification {
    struct Login {
        static let invalid          =   "ZXNOTICE_LOGIN_OFFLINE"                //登录失效通知
        static let success          =   "ZXNOTICE_LOGIN_SUCCESS"                //登录成功
        static let accountChanged   =   "ZXNOTICE_LOGIN_ACCOUNT_CHANGED"        //用户已切换
    }
    
    struct Order {
        static let paySuccess       =   "ZXNOTICE_ORDER_PAY_SUCCESS"            //订单支付成功
        static let update           =   "ZXNOTICE_ORDER_STATUS_UPDATE"
        static let payPagePop       =   "ZXNOTICE_PAY_PAGE_POP"                 //支付状态位置,返回上一个界面
    }
    
    struct Report {
        static let deleteSuccess       =   "ZXNOTICE_REPORT_DELETE_SUCCESS"     //添加处方
    }
    
    struct Prescription {
        static let addSuccess       =   "ZXNOTICE_PRESCRIPTION_ADD_SUCCESS"     //添加处方
    }
    
    struct Member {
        static let joinSuccess      =   "ZXNOTICE_MEMBER_JOIN_SUCCESS"
        static let receiveRemoteN   =   "ZXNOTICE_MEMBER_RECEIVE_REMOTE_N"
    }
    
    struct UI {
        static let reload           =   "ZXNOTICE_RELOAD_UI"
        static let badgeReload      =   "ZXNOTICE_RELOAD_BADGE"
        static let enterForeground  =   "ZXNOTICE_ENTERFOREGROUND"
    }
    
    struct Personal {
        static let ModifyNikeName   =   "ZXNOTICE_Personal_ModifyNikeName"
        static let ModifyHeaderIcon =   "ZXNOTICE_Personal_ModifyHeaderIcon"
        static let ModifyUserTel    =   "ZXNOTICE_Personal_ModifyUserTel"
    }
    
    struct Remind {
        static let ModifyTime       =   "ZXNOTICE_NOTIFICATION_ModifyTime"
    }
    
    struct BMap {
        static let isOpenLocation   =   "ZXNOTICE_BMap_IsOpenLoaction"
    }
    
    struct Notice {
        static let open      = "ZXNOTICE_Notice_IsOpen"
    }
}


extension NotificationCenter {
    struct zxpost {
        
        /// 判断定位是否开启
        static func judgementLocationStatus(_ isOpen: Bool) {
            NotificationCenter.default.post(name:ZXNotification.BMap.isOpenLocation.zx_noticeName(), object: isOpen)
        }
        
        /// 订单状态修改成功
        static func orderStatusUpdated() {
            NotificationCenter.default.post(name: ZXNotification.Order.update.zx_noticeName(), object: nil)
        }
        
        /// 化验单删除
        static func reportDeleted() {
            NotificationCenter.default.post(name: ZXNotification.Report.deleteSuccess.zx_noticeName(), object: nil)
        }
        
        /// 处方添加成功
        static func prescriptionAdded() {
            NotificationCenter.default.post(name: ZXNotification.Prescription.addSuccess.zx_noticeName(), object: nil)
        }
        
        static func accountChanged() {
            NotificationCenter.default.post(name: ZXNotification.Login.accountChanged.zx_noticeName(), object: nil)
        }
        
        static func loginSuccess() {
            NotificationCenter.default.post(name: ZXNotification.Login.success.zx_noticeName(), object: nil)
        }
        
        static func loginInvalid() {
            NotificationCenter.default.post(name: ZXNotification.Login.invalid.zx_noticeName(), object: nil)
        }
        
        static func reloadUI() {
            NotificationCenter.default.post(name: ZXNotification.UI.reload.zx_noticeName(), object: nil)
        }
        
        static func reloadBadge() {
            NotificationCenter.default.post(name: ZXNotification.UI.badgeReload.zx_noticeName(), object: nil)
        }
        
        static func openNotice(_ succ: Bool) {
            NotificationCenter.default.post(name: ZXNotification.Notice.open.zx_noticeName(), object: nil)
        }
    }
}