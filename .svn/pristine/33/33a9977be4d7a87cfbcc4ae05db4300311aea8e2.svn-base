//
//  ZXRouter+RemoteNotification.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/4/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

enum ZXRemoteNoticeType {
    case couponUpdate,promotionUpdate,orderUpdate,takeMedicine,unknown
}

@objcMembers class ApsModel:NSObject {
    var alert:Any?  //支持iOS10
    var badge:Int = 0
    var title:String {
        get {
            if let alert = alert as? Dictionary<String,Any> {
                return (alert["title"] as? String) ?? "新消息"
            }
            return "新消息"
        }
    }
    
    var body:String {
        get {
            if let alert = alert as? String {
                return alert
            } else if let alert = alert as? Dictionary<String,Any> {
                return (alert["body"] as? String) ?? "新消息"
            }
            return ""
        }
    }
}

@objcMembers class ZXRemoteNoticeModel:NSObject {
    static var lastNoticeInfo:Dictionary<String,Any>?
    var aps = ApsModel()
    var pushId = ""
    var pushType = ""           //文本
    var remindTime = ""         //提醒时间
    var remindDetailTime = ""   //提醒详细日期时间
    
    var fromUserTap = false
    var zx_type:ZXRemoteNoticeType {
        get{
            if pushType == "remind" {
                return  .takeMedicine
            } else if pushType == "coupon" {
                return .couponUpdate
            } else if pushType == "order" {
                return .orderUpdate
            } else if pushType == "promotion" {
                return .promotionUpdate
            }
            return .unknown
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}


extension ZXRouter {
    
    static func showNotice(_ infoDic:Dictionary<String,Any>?) {
        if let infoDic = infoDic{
            guard let noticeModel = ZXRemoteNoticeModel.mj_object(withKeyValues: infoDic) else {
                return
            }
            let rootvc = UIApplication.shared.keyWindow?.rootViewController
            if rootvc == ZXRootController.zx_tabbarVC() {
                var selectedVc = ZXRootController.zx_tabbarVC().selectedViewController
                var nav:UIViewController?
                if ZXRootController.zx_tabbarVC().presentedViewController != nil{
                    selectedVc = ZXRootController.zx_tabbarVC().presentedViewController
                }
                if let navVC = selectedVc as? UINavigationController {
                    nav = navVC
                    selectedVc = navVC.viewControllers.first
                }else{
                    nav = selectedVc?.navigationController
                }
                if selectedVc is ZXLaunchRootViewController ||
                    selectedVc is ZXLoginRootViewController ||
                    selectedVc is ZXUserInfoViewController ||
                    selectedVc is ZXFlashScreenViewController{
                    ZXRemoteNoticeModel.lastNoticeInfo = infoDic
                    return
                }
                
                if  let nav = nav as? UINavigationController {
                    ZXRemoteNoticeModel.lastNoticeInfo = nil
                    if noticeModel.zx_type == .unknown {
                        ZXAudioUtils.vibrate()
                        ZXAlertUtils.showAlert(withTitle: noticeModel.aps.title, message: noticeModel.aps.body)
                    } else {
                        if noticeModel.zx_type == .takeMedicine {//用药提醒 present 不需要警告框
                            if !noticeModel.fromUserTap {
                                if ZXUser.user.isVoiceRemind == 1 {
                                    ZXAudioUtils.takeMedicineAudio()
                                } else {
                                    ZXAudioUtils.vibrate()
                                }
                            } else {
                                ZXAudioUtils.vibrate()
                            }
                            ZXDrugNoticeViewModel.getMedicineList(remindIds: noticeModel.pushId, deailTime: noticeModel.remindDetailTime, completion: { (code, list) in
                                if let list = list {
                                    let detailVC = ZXDrugNoticeViewController()
                                    detailVC.list = list
                                    ZXRootController.topVC().present(detailVC, animated: true, completion: nil)
                                }
                            })
                            
                        } else {
                            NotificationCenter.default.post(name: ZXNotification.Member.receiveRemoteN.zx_noticeName(), object: nil)
                            ZXAudioUtils.vibrate()
                            ZXAlertUtils.showAlert(wihtTitle: noticeModel.aps.title, message: noticeModel.aps.body, buttonTexts: ["忽略","马上查看"], action: { (index) in
                                if index == 1 {
                                    if noticeModel.zx_type == .couponUpdate {
                                        let cashCoupon = ZXCashCouponListViewController()
                                        cashCoupon.isValid = true
                                        nav.pushViewController(cashCoupon, animated: true)
                                    } else if noticeModel.zx_type == .promotionUpdate {
                                        let messageDetail = ZXSystemMessageDetailViewController()
                                        messageDetail.messageId = noticeModel.pushId
                                        messageDetail.type = 2
                                        nav.pushViewController(messageDetail, animated: true)
                                    } else if noticeModel.zx_type == .orderUpdate { //
                                        let orderDetail = ZXUCOrderDetailViewController()
                                        orderDetail.orderId = noticeModel.pushId
                                        nav.pushViewController(orderDetail, animated: true)
                                    }
                                }
                            })
                        }
                    }
                } else {
                    ZXRemoteNoticeModel.lastNoticeInfo = infoDic
                    return
                }
            } else {
                ZXRemoteNoticeModel.lastNoticeInfo = infoDic
            }
        } else {
            ZXRemoteNoticeModel.lastNoticeInfo = nil
        }
    }

    static func checkLastCacheRemoteNotice() {
        self.showNotice(ZXRemoteNoticeModel.lastNoticeInfo)
    }
    
}
