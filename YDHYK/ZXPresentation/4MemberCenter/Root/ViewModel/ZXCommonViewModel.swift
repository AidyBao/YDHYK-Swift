//
//  ZXCommonViewModel.swift
//  YDHYK
//
//  Created by screson on 2017/11/15.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

enum ZXConstDicType: UInt {
    case ageGroup       =   1   //年龄段数据
    case remindCycle    =   8   //用药提醒周期
    case drugUnit       =   10  //用药单位
    case checkItems     =   14  //检查项
    case checkTemplate  =   15  //化验单模板
    case none           =   0
}
/**常量数据字典*/
@objcMembers class ZXConstDicModel: NSObject {
    var type: UInt = 0   //常量类型 1 8 10 14 15
    var typeLabel = ""  //类型说明
    var key = ""        //常量ID
    var value = ""      //常量值
    var remark = ""     //备注
    
    var zx_type: ZXConstDicType {
        get {
            if let zxtype = ZXConstDicType.init(rawValue: self.type) {
                return zxtype
            }
            return .none
        }
    }
}


/// 个人中心角标 会员积分
@objcMembers class ZXAllUnReadCountModel: NSObject {
    /**促销未读数*/
    var promotionUnRead = 0
    /**现金券未读数*/
    var couponUnRead = 0
    /**待支付订单数*/
    var notPayNum = 0
    /**待提货订单数*/
    var notTakeNum = 0
    /**待发货订单数*/
    var notSendNum = 0
    /**待收货订单数*/
    var notReciveNum = 0
    /**会员积分*/
    var integral = 0
}

/// CommonViewModel
class ZXCommonViewModel: NSObject {
    
    /// 获取所有角标信息
    ///
    /// - Parameter completion:
    static func fetchAllUnReadMessageCount(completion: ((_ model: ZXAllUnReadCountModel?) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Common.unReadMsg), params: nil, method: .post) { (success, code, obj, _, error) in
            if code == ZXAPI_SUCCESS {
                if let data = obj["data"] as? Dictionary<String,Any> {
                    if let model = ZXAllUnReadCountModel.mj_object(withKeyValues: data) {
                        completion?(model)
                    } else {
                        completion?(nil)
                    }
                }else {
                    completion?(nil)
                }
            } else {
                completion?(nil)
            }
        }
    }
    
    /// 获取数据字典
    ///
    /// - Parameters:
    ///   - type:
    ///   - completion:
    static func getConstDic(with type: ZXConstDicType,completion: ((_ success: Bool, _ code: Int,_ list: [ZXConstDicModel]?,_ errorMsg: String) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Common.dicList), params: ["type": type.rawValue], method: .post) { (success, code, obj, _, error) in
            if code == ZXAPI_SUCCESS {
                if let data = obj["data"] as? Array<Dictionary<String,Any>> {
                    var list: Array<ZXConstDicModel> = []
                    for d in data {
                        if let model = ZXConstDicModel.mj_object(withKeyValues: d) {
                            list.append(model)
                        }
                    }
                    completion?(true,code,list,"")
                } else {
                    completion?(false,code,nil,"无相关数据")
                }
            } else {
                completion?(false,code,nil, error?.errorMessage ?? "未知错误")
            }
        }
    }
    
    /// 打开关闭语音提醒
    ///
    /// - Parameter completion:
    static func setVoiceRemindOn(_ isOn: Bool,completion:((_ success: Bool,_ code: Int, _ errorMsg: String) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.RemoteNotice.voiceRemind), params: ["isVoiceRemind": isOn ? 1 : 0], method: .post) { (success, code, obj, _, error) in
            if code == ZXAPI_SUCCESS {
                completion?(true, code, "")
            } else {
                completion?(false, code, error?.errorMessage ?? "未知错误")
            }
        }

    }
}
