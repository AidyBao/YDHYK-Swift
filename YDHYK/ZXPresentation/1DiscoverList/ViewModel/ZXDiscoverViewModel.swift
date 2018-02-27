//
//  ZXDiscoverViewModel.swift
//  YDHYK
//
//  Created by screson on 2017/11/3.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXDiscoverViewModel: NSObject {
    static func loadList(pageNum: Int,
                         pageSize: Int,
                         completion: ((_ success: Bool,_ code: Int,_ list: [ZXDiscoverModel]?,_ errorMsg: String) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Discover.list), params: ["pageNum": pageNum, "pageSize": pageSize].zx_signDic(), method: .post) { (s, c, obj, _, error) in
            if s {
                if let data = obj["data"] as? Dictionary<String,Any>,let list = data["listData"] as? Array<Dictionary<String,Any>> {
                    var dList: Array<ZXDiscoverModel> = []
                    for m in list {
                        if let discover = ZXDiscoverModel.mj_object(withKeyValues: m) {
                            dList.append(discover)
                        }
                    }
                    completion?(s,c,dList,"")
                } else {
                    completion?(s,c,[],"无相关数据")
                }
            } else {
                completion?(s,c,nil,error?.errorMessage ?? "")
            }
        }
    }
    
    /// 发现-详情
    ///
    /// - Parameters:
    ///   - promotionId:
    ///   - completion:
    static func loadDetail(promotionId: String,
                           completion: ((_ success: Bool,_ code: Int,_ model: ZXDiscoverModel?,_ errorMsg: String) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Discover.detail), params: ["promotionId": promotionId].zx_signDic(), method: .post) { (s, c, obj, _, error) in
            if s {
                if let data = obj["data"] as? Dictionary<String,Any> {
                    completion?(s,c,ZXDiscoverModel.mj_object(withKeyValues: data),"")
                } else {
                    completion?(s,c,nil,"无相关数据")
                }
            } else {
                completion?(s,c,nil,error?.errorMessage ?? "")
            }
        }
    }
}
