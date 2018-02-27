//
//  ZXDrugViewModel.swift
//  YDHYK
//
//  Created by screson on 2017/10/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
//所有接口durgId均为基础药品Id

/// DrugViewModel
@objcMembers class ZXDrugViewModel: NSObject {
    
    /// 药品收藏/取消收藏
    ///
    /// - Parameters:
    ///   - mark: （可以不传,系统自动判断 收藏/取消收藏）
    ///   - drugId:
    ///   - storeId:
    ///   - collectPrice:
    ///   - completion:
    static func markDrug(_ mark:Bool,
                         drugId:String,
                         storeId:String,
                         collectPrice:String,
                       completion:((_ code:Int,_ success:Bool,_ errorMsg:String) -> Void)?) {
        var dicp:Dictionary<String,Any> = [:]
        dicp["drugstoreId"] = storeId
        dicp["drugId"] = drugId
        dicp["collectPrice"] = collectPrice
        ZXNetwork.asyncRequest(withUrl: ZXAPI.store(address: ZXAPIConst.Store.markDrug), params: dicp.zx_signDic(), method: .post) { (success, code, obj, _, error) in
            if success {
                completion?(code,true,(error?.errorMessage) ?? "")
            }else{
                completion?(code,false,(error?.errorMessage) ?? "")
            }
        }
    }

    
    /// 药品详情
    ///
    /// - Parameters:
    ///   - drugId: (基础药品Id)
    ///   - storeId:
    ///   - approvalNum:
    ///   - completion:
    static func durgDetailInfo(_ drugId:String,
                               storeId:String,
                               approvalNum:String,
                               completion:((_ code:Int,_ success:Bool,_ drugInfo:ZXDrugDetailModel?,_ storeInfo:ZXStoreDetailModel?,_ errorMsg:String) -> Void)?) {
        var dicp:Dictionary<String,Any> = [:]
        dicp["drugstoreId"] = storeId
        dicp["drugId"] = drugId
        if approvalNum.count > 0 {
            dicp["approvalNumber"] = approvalNum
        }
        ZXNetwork.asyncRequest(withUrl: ZXAPI.store(address: ZXAPIConst.Store.drugDetail), params: dicp.zx_signDic(), method: .post) { (success, code, obj, _, error) in
            if success {
                if let data = obj["data"] as? Dictionary<String,Any>,let drug = data["drug"] as? Dictionary<String,Any>,let store = data["drugstore"] as? Dictionary<String,Any> {

                    completion?(code,true,ZXDrugDetailModel.mj_object(withKeyValues: drug),ZXStoreDetailModel.mj_object(withKeyValues: store),(error?.errorMessage) ?? "")
                } else {
                    completion?(code,true,nil,nil,(error?.errorMessage) ?? "获取数据失败或无相关信息")
                }
            }else{
                completion?(code,false,nil,nil,(error?.errorMessage) ?? "")
            }

        }
        self.record(drugId: drugId, storeId: storeId, approvalNumber: approvalNum)
    }
    
    /// 添加商品浏览记录
    ///
    /// - Parameters:
    ///   - drugId:
    ///   - storeId:
    ///   - approvalNumber:
    static func record(drugId:String,
                       storeId:String,
                       approvalNumber:String) {
        var dicp:Dictionary<String,Any> = [:]
        dicp["drugstoreId"] = storeId
        dicp["drugId"] = drugId
        dicp["approvalNumber"] = approvalNumber
        ZXNetwork.asyncRequest(withUrl: ZXAPI.store(address: ZXAPIConst.Store.recordDrug), params: dicp.zx_signDic(), method: .post) { _,_,_,_,_  in
            
        }
    }
    
    /// randomList / 商品详情 关联商品推荐
    ///
    /// - Parameters:
    ///   - storeId:
    ///   - completion:
    static func randomList(storeId: String,
                           completion:((_ status: Bool,_ code: Int,_ errorMsg: String,_ model: [ZXDrugModel]) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.store(address: ZXAPIConst.Store.relateDrugList), params: ["drugstoreId":storeId].zx_signDic(), method: .post) { (success, code, obj, _, error) in
            if code == ZXAPI_SUCCESS {
                if let data = obj["data"] as? Array<Any>,data.count > 0 {
                    var list: Array<ZXDrugModel> = []
                    for m in data {
                        list.append(ZXDrugModel.mj_object(withKeyValues: m))
                    }
                    completion?(true,code,"",list)
                } else {
                    completion?(true,code,error?.errorMessage ?? "",[])
                }
            } else {
                completion?(false,code,error?.errorMessage ?? "",[])
            }
        }
    }
}
