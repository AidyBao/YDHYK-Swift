//
//  ZXJoinMemberViewModel.swift
//  YDHYK
//
//  Created by screson on 2017/11/3.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 药店会员
class ZXStoreMemberViewModel: NSObject {
    
    /// 加入会员
    ///
    /// - Parameters:
    ///   - storeId:
    ///   - userId: 推荐的店员Id
    ///   - completion:
    static func joinTo(storeId: String,
                       userId: String?,
                       location:CLLocation,
                       completion: ((_ isNew: Bool,_ success:Bool, _ code: Int, _ errorMsg: String) -> Void)?) {
        var dicp: Dictionary<String,Any> = [:]
        dicp["drugstoreId"] = storeId
        if let userId = userId {
            dicp["userId"] = userId
        }
        
        if location.coordinate.latitude <= 0,location.coordinate.longitude <= 0 {
            dicp["joinLatitude"] = ZX.Location.latitude
            dicp["joinLongitude"] = ZX.Location.longitude
        } else {
            dicp["joinLatitude"] = location.coordinate.latitude
            dicp["joinLongitude"] = location.coordinate.longitude
        }
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.StoreMember.join), params: dicp.zx_signDic(), method: .post) { (s, c, obj, _, error) in
            if s {
                var isNew = false
                if let data = obj["data"] as? Dictionary<String,Any>,let iNew = data["isNew"] as? Int, iNew == 1 {
                    isNew = true
                }
                completion?(isNew,true,c,"")
            } else {
                completion?(false,false,c,error?.errorMessage ?? "未知错误")
            }
        }
    }
    
    /// 是否是店铺会员
    ///
    /// - Parameters:
    ///   - storeId:
    ///   - completion:
    static func validMember(storeId: String,
                            completion: ((_ isMember: Bool,_ success:Bool, _ storeName: String) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.StoreMember.isOldMember), params: ["drugstoreId": storeId].zx_signDic(), method: .post) { (s, c, obj, _, error) in
            if s {
                var isOldMember = false
                var storeName = ""
                if let data = obj["data"] as? Dictionary<String,Any>,let isMe = data["isDrugstoreMember"] as? Int, isMe == 1 {
                    isOldMember = true
                    if let store = data["drugstore"] as? Dictionary<String,Any> {
                        storeName = (store["name"] as? String) ?? ""
                    }
                }
                completion?(isOldMember,true,storeName)
            } else {
                completion?(false,false,error?.errorMessage ?? "未知错误")
            }
        }
    }
    
    /// 会员-药店基础信息
    ///
    /// - Parameters:
    ///   - storeId:
    ///   - completion:
    static func storeShortInfo(storeId: String,
                               completion: ((_ success: Bool, _ code: Int, _ store: ZXStoreShortModel?, _ errorMsg: String) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.StoreMember.storeInfo), params: ["drugstoreId": storeId].zx_signDic(), method: .post) { (s, c, obj, _, error) in
            if s {
                if let data = obj["data"] as? Dictionary<String,Any> {
                    completion?(true,c,ZXStoreShortModel.mj_object(withKeyValues: data),"")
                }
                completion?(true,c,nil,"")
            } else {
                completion?(false,c,nil,error?.errorMessage ?? "未知错误")
            }
        }
    }
    
    /// 新加入的会员 关联该店铺历史现金券
    /// 接口失败不做二次处理
    static func dispatchHistoryCoupon(storeId: String,to memberId: String? = nil) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.StoreMember.historyCoupon), params: ["drugstoreId": storeId].zx_signDic(), method: .post) { _,_,_,_,_  in
            
        }
    }
    
    /// 新加入的会员 关联该店铺历史促销信息
    /// 接口失败不做二次处理
    static func deliverHistoryPromotion(storeId: String,to memberId: String) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.StoreMember.historyPromotion), params: ["drugstoreId": storeId].zx_signDic(), method: .post) { _,_,_,_,_  in
            
        }
    }
}
