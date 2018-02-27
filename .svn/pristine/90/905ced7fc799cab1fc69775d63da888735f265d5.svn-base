//
//  ZXStoreHomeViewModel.swift
//  YDHYK
//
//  Created by screson on 2017/10/12.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

@objcMembers class ZXStoreHomeViewModel: NSObject {
    
    /// 药店首页配置内容
    ///
    /// - Parameters:
    ///   - storeId:
    ///   - completion:
    static func getHomePage(storeId: String,
                            completion:((_ status: Bool,_ code: Int,_ errorMsg: String,_ model: ZXStoreModel?) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.store(address: ZXAPIConst.Store.home), params: ["drugstoreId":storeId].zx_signDic(), method: .post) { (success, code, obj, _, error) in
            if code == ZXAPI_SUCCESS {
                if let data = obj["data"] as? Dictionary<String,Any>,let model = ZXStoreModel.mj_object(withKeyValues: data) {
                    completion?(true,code,"",model)
                } else {
                    completion?(true,code,error?.errorMessage ?? "",nil)
                }
            } else {
                completion?(false,code,error?.errorMessage ?? "",nil)
            }
        }
    }
    
    /// 猜您需药
    ///
    /// - Parameters:
    ///   - storeId:
    ///   - completion:
    static func recommendList(storeId: String,
                              completion:((_ status: Bool,_ code: Int,_ errorMsg: String,_ model: [ZXDrugModel]) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.store(address: ZXAPIConst.Store.recommendDrugList), params: ["drugstoreId":storeId].zx_signDic(), method: .post) { (success, code, obj, _, error) in
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
    
    /// 药品分类树
    ///
    /// - Parameters:
    ///   - storeId:
    ///   - completion:
    static func categoryTree(storeId: String,
                             completion:((_ status: Bool,_ code: Int,_ errorMsg: String,_ model: [ZXCategoryTreeModel]) -> Void)?) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.store(address: ZXAPIConst.Store.categoryTree), params: ["drugstoreId":storeId].zx_signDic(), method: .post) { (success, code, obj, _, error) in
            if code == ZXAPI_SUCCESS {
                if let data = obj["data"] as? Array<Any>,data.count > 0 {
                    var list: Array<ZXCategoryTreeModel> = []
                    for m in data {
                        list.append(ZXCategoryTreeModel.mj_object(withKeyValues: m))
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
    
    /// 药品列表检索、分类检索
    ///
    /// - Parameters:
    ///   - searchValue:
    ///   - categoryId:
    ///   - pageNum:
    ///   - pageSize:
    ///   - storeId:
    ///   - completion:
    static func searchDrugList(_ searchValue:String?,
                               categoryId:String?,
                               pageNum:Int,
                               pageSize:Int,
                               storeId:String,
                               completion:((_ code:Int,_ success:Bool,_ list:Array<ZXDrugModel>?,_ msg:String) -> Void)?) {
        var dicp:Dictionary<String,Any> = [:]
        dicp["drugstoreId"]  = storeId
        if let searchValue = searchValue {//模糊搜索条件 当drugSortId为空时必填
            dicp["searchName"] = searchValue
        } else if let categoryId = categoryId{//药品类型ID
            dicp["drugSortId"] = categoryId
        }
        dicp["pageNum"] = (pageNum <= 0 ? 0 : pageNum)
        dicp["pageSize"] = (pageSize <= 0 ? 0 : pageSize)
        
        ZXNetwork.asyncRequest(withUrl: ZXAPI.store(address: ZXAPIConst.Store.searchDrug), params: dicp.zx_signDic(), method: .post) { (success, code, obj, _, error) in
            if success {
                if let data = obj["data"] as? Dictionary<String,Any> {
                    if let listData = data["listData"] as? Array<Any>,listData.count > 0 {
                        var list = [ZXDrugModel]()
                        for dic in listData {
                            list.append(ZXDrugModel.mj_object(withKeyValues: dic))
                        }
                        completion?(code,true,list,"")
                    } else {
                        completion?(code,true,nil,error?.errorMessage ?? "")
                    }
                } else {
                    completion?(code,true,nil,error?.errorMessage ?? "")
                }
            } else {
                completion?(code,false,nil,error?.errorMessage ?? "")
            }
        }
    }
    
    
    /// 活动商品列表
    ///
    /// - Parameters:
    ///   - drugstoreTemplateId:
    ///   - activeItem:
    ///   - pageNum:
    ///   - pageSize:
    ///   - storeId:
    ///   - completion:
    static func activeList(_ drugstoreTemplateId: String?,
                           activeItem: String?,
                           pageNum: Int,
                           pageSize: Int,
                           storeId: String,
                           completion: ((_ code:Int,_ success:Bool,_ list:Array<ZXDrugModel>?,_ msg:String) -> Void)?) {
        var dicp:Dictionary<String,Any> = [:]
        dicp["drugstoreTemplateId"] = drugstoreTemplateId
        dicp["activeItem"] = activeItem
        dicp["drugstoreId"]  = storeId
        dicp["pageNum"] = (pageNum <= 0 ? 0 : pageNum)
        dicp["pageSize"] = (pageSize <= 0 ? 0 : pageSize)
        ZXNetwork.asyncRequest(withUrl: ZXAPI.store(address: ZXAPIConst.Store.activeList), params: dicp.zx_signDic(), method: .post) { (success, code, obj, _, error) in
            if success {
                if let data = obj["data"] as? Dictionary<String,Any> {
                    if let listData = data["listData"] as? Array<Any>,listData.count > 0 {
                        var list = [ZXDrugModel]()
                        for dic in listData {
                            list.append(ZXDrugModel.mj_object(withKeyValues: dic))
                        }
                        completion?(code,true,list,"")
                    } else {
                        completion?(code,true,nil,error?.errorMessage ?? "")
                    }
                } else {
                    completion?(code,true,nil,error?.errorMessage ?? "")
                }
            } else {
                completion?(code,false,nil,error?.errorMessage ?? "")
            }
        }
    }
}
