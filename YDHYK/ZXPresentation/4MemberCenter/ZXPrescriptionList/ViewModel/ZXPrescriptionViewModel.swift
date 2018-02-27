//
//  ZXPrescriptionViewModel.swift
//  YDHYK
//
//  Created by screson on 2017/11/9.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 处方Model
@objcMembers class ZXPrescriptionModel: NSObject {
    var pId = ""
    var title = ""
    var attachFilesStr = ""
    var uploadDateStr = ""
    
    var zx_imageUrl: URL? {
        get {
            let list = attachFilesStr.components(separatedBy: ",")
            if let first = list.first {
                return URL.init(string: first)
            }
            return nil
        }
    }
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["pId": "id"]
    }
}

/// 处方ViewModel
class ZXPrescriptionViewModel: NSObject {
    
    /// 处方列表
    ///
    /// - Parameters:
    ///   - pageNum:
    ///   - pageSize:
    ///   - completion:
    static func list(pageNum: Int,
                     pageSize: Int,
                     completion: ((_ success: Bool, _ code: Int, _ list: [ZXPrescriptionModel]?, _ errorMsg: String) -> Void)?) {
        var dicP: Dictionary<String, Any> = [:]
        dicP["pageNum"] = (pageNum <= 0 ? 1 : pageNum)
        dicP["pageSize"] = (pageSize <= 0 ? ZX.PageSize : pageSize)
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Prescription.list), params: dicP, method: .post) { (success, code, obj, _, error) in
            if code == ZXAPI_SUCCESS {
                if let data = obj["data"] as? Dictionary<String, Any>,let listData = data["listData"] as? Array<Dictionary<String, Any>> {
                    var tList: Array<ZXPrescriptionModel> = []
                    for d in listData {
                        if let coupon = ZXPrescriptionModel.mj_object(withKeyValues: d) {
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
    
    /// 新增处方
    ///
    /// - Parameters:
    ///   - title:
    ///   - paths: 多张时逗号分割 【先通过文件上传接口上传获取地址】
    ///   - completion:
    static func add(with title: String,
                    images paths: String,
                    completion:((_ success: Bool, _ errorMsg: String) -> Void)?) {
        var dicP: Dictionary<String, Any> = [:]
        dicP["title"] = title
        dicP["attachFiles"] = paths
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Prescription.add), params: dicP, method: .post) { (success, code, obj, _, error) in
            if code == ZXAPI_SUCCESS {
                completion?(true, "")
            } else {
                completion?(false,error?.errorMessage ?? "未知错误")
            }
        }
    }
    
    /// 删除处方
    ///
    /// - Parameters:
    ///   - pId:
    ///   - completion:
    static func delete(_ pId: String,
                    completion:((_ success: Bool, _ errorMsg: String) -> Void)?) {
        var dicP: Dictionary<String, Any> = [:]
        dicP["id"] = pId
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Prescription.delete), params: dicP, method: .post) { (success, code, obj, _, error) in
            if code == ZXAPI_SUCCESS {
                completion?(true, "")
            } else {
                completion?(false,error?.errorMessage ?? "未知错误")
            }
        }
    }
}
