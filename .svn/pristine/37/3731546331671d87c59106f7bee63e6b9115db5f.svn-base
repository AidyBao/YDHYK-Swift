//
//  ZXUCOrderViewModel.swift
//  YDHYK
//
//  Created by screson on 2017/11/6.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
/// ZXUserCenterOrderViewModel
class ZXUCOrderViewModel: NSObject {
    
    /// 用户中心订单列表
    ///
    /// - Parameters:
    ///   - pageNum:
    ///   - pageSize:
    ///   - status: 订单状态 待取货 传 4 内部处理为“4,8” 待收货 传1 内部处理为“1,8”
    ///   - type: 配送方式 自提 送货上门
    ///   - completion:
    static func orderList(pageNum: Int,
                          pageSize: Int,
                          status: ZXUCOrderStatus,
                          type: ZXUCOrderReceivingType,
                          completion: ((_ success: Bool,_ code: Int,_ list:[ZXUCOrderDetailModel]?,_ errorMsg: String) -> Void)?) {
        var dicP: Dictionary<String, Any> = [:]
        //提货方式 //全部订单 提货方式 "1,2"或不传
        if type != .all {
            dicP["receiveType"] = type.rawValue
        }
        //订单状态
        if status != .all {
            if status == .waitTake {
                dicP["status"] = "4,8"
            } else if status == .waitDispatch {
                dicP["status"] = "1,8"
            } else {
                dicP["status"] = status.rawValue
            }
        }
        dicP["pageNum"] = pageNum <= 0 ? 1 : pageNum
        dicP["pageSize"] = pageSize <= 0 ? 1 : pageSize
        
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Order.list), params: dicP, method: .post) { (s, c, obj, _, error) in
            if c == ZXAPI_SUCCESS {
                if let data = obj["data"] as? Dictionary<String, Any>, let listData = data["listData"] as? Array<Dictionary<String, Any>> {
                    var list: Array<ZXUCOrderDetailModel> = []
                    for d in listData {
                        if let order = ZXUCOrderDetailModel.mj_object(withKeyValues: d) {
                            list.append(order)
                        }
                    }
                    completion?(true, c, list,"")
                } else {
                    completion?(false, c, nil,"无相关数据")
                }
            } else {
                completion?(false, c, nil, error?.errorMessage ?? "未知错误")
            }
        }
    }
    
    /// 个人中心订单详情
    ///
    /// - Parameters:
    ///   - orderId:
    ///   - completion:
    static func orderDetail(with orderId: String,
                            completion: ((_ success: Bool,_ code: Int,_ orderDetail:ZXUCOrderDetailModel?,_ errorMsg: String) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Order.detail), params: ["orderId": orderId], method: .post) { (s, c, obj, _, error) in
            if c == ZXAPI_SUCCESS {
                if let data = obj["data"] as? Dictionary<String, Any> {
                    if let order = ZXUCOrderDetailModel.mj_object(withKeyValues: data) {
                        completion?(true, c, order,"")
                    } else {
                        completion?(false, c, nil,"无相关订单信息")
                    }
                } else {
                    completion?(false, c, nil,"无相关订单信息")
                }
            } else {
                completion?(false, c, nil, error?.errorMessage ?? "未知错误")
            }
        }
    }
    
    /// 个人中心订单操作 - 修改订单状态
    ///
    /// - Parameters:
    ///   - orderId:
    ///   - status:
    ///   - completion:
    static func changeOrder(_ orderId: String,
                            to status: ZXUCOrderStatus,
                            completion: ((_ success: Bool,_ code: Int,_ errorMsg: String) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Order.update), params: ["orderId": orderId,"status": status.rawValue], method: .post) { (s, c, obj, _, error) in
            if c == ZXAPI_SUCCESS {
                completion?(true, c, "")
            } else {
                completion?(false, c, error?.errorMessage ?? "未知错误")
            }
        }
    }
    
    /// 订单提货码
    ///
    /// - Parameters:
    ///   - orderId:
    ///   - completion: 
    static func pickupCode(orderId: String,
                           completion: ((_ success: Bool,_ code: Int,_ qrCodeImage: UIImage?,_ pickupCode: String?,_ errorMsg: String) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Order.pickupCode), params: ["orderId": orderId], method: .post) { (s, c, obj, _, error) in
            if c == ZXAPI_SUCCESS {
                var pickupCode = ""
                if let code = obj["code"] as? NSNumber {//二维码code verificateCode不需要
                    pickupCode = code.stringValue
                }
                if pickupCode.count > 0 {
                    if let str = obj["qrCode"] as? String {
                        var image: UIImage?
                        if let base64Data = NSData.init(base64Encoded: str, options: NSData.Base64DecodingOptions(rawValue: 0)) as Data? {
                            image = UIImage.init(data: base64Data)
                        }
                        completion?(true, c, image ,pickupCode, "")
                    } else {
                        completion?(false, c, nil ,nil, error?.errorMessage ?? "解析数据失败")
                    }
                } else {
                    completion?(false, c, nil ,nil, error?.errorMessage ?? "解析数据失败")
                }
            } else {
                completion?(false, c, nil ,nil, error?.errorMessage ?? "未知错误")
            }
        }

    }
}
