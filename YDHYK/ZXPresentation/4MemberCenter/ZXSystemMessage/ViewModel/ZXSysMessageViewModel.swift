//
//  ZXSysMessageViewModel.swift
//  YDHYK
//
//  Created by screson on 2017/11/10.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

@objcMembers class ZXMessageSortModel: NSObject {
    var msgId = ""
    var title = ""
    var isRead: Int = 0 //1：已读 0：未读
    var sendDateStr = ""
    var type: Int = 1   //1：现金券 2：促销活动
    var zx_description: String {//描述：您有一张新的现金券，有一个新的促销活动
        get {
            if type == 1 {
                return "您有一张新的现金券"
            }
            return "有一个新的促销活动"
        }
    }
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["msgId": "id"]
    }
}

@objcMembers class ZXMessageDetailModel: NSObject {
    var msgId = ""
    var title = ""
    var content = ""    //type=1 现金券 时无该字段
    var useRule = ""    //type=2 促销活动 时无该字段
    var sendDateStr = ""
    
    var zx_content: String {
        get {
            return content + "\n" + useRule
        }
    }
}

class ZXSysMessageViewModel: NSObject {
    
    /// 系统消息列表
    ///
    /// - Parameters:
    ///   - pageNum:
    ///   - pageSize:
    ///   - completion:
    static func list(pageNum: Int,
                     pageSize: Int,
                     completion: ((_ success: Bool, _ code: Int, _ list: [ZXMessageSortModel]?, _ errorMsg: String) -> Void)?) {
        var dicP: Dictionary<String, Any> = [:]
        dicP["pageNum"] = (pageNum <= 0 ? 1 : pageNum)
        dicP["pageSize"] = (pageSize <= 0 ? ZX.PageSize : pageSize)
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Message.list), params: dicP, method: .post) { (success, code, obj, _, error) in
            if code == ZXAPI_SUCCESS {
                if let data = obj["data"] as? Dictionary<String, Any>,let listData = data["listData"] as? Array<Dictionary<String, Any>> {
                    var tList: Array<ZXMessageSortModel> = []
                    for d in listData {
                        if let coupon = ZXMessageSortModel.mj_object(withKeyValues: d) {
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

    
    /// 消息详情
    ///
    /// - Parameters:
    ///   - mId:
    ///   - completion:
    static func detail(with mId: String,
                       type: String,
                       completion:((_ success: Bool,_ model: ZXMessageDetailModel?,_ errorMsg: String) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Message.detail), params: ["id": mId,"type": type], method: .post) { (success, code, obj, _, error) in
            if code == ZXAPI_SUCCESS {
                if let data = obj["data"] as? Dictionary<String, Any> {
                    completion?(true,ZXMessageDetailModel.mj_object(withKeyValues: data),"")
                } else {
                    completion?(true,nil,"无相关数据")
                }
            } else {
                if code != ZXAPI_LOGIN_INVALID {
                    completion?(false,nil,error?.errorMessage ?? "未知错误")
                }
            }
        }

    }
}
