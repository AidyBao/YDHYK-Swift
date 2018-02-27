//
//  ZXRemindController.swift
//  YDHYK
//
//  Created by 120v on 2017/11/23.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

typealias requestCompletion = (_ succ:Bool, _ code: Int, _ listModel:Array<Any>?,_ errMsg: String) -> Void

class ZXRemindController: NSObject {
    //MARK: - 按时间查询用药提醒
    class func requestForSearchByRemindTime(completion:@escaping requestCompletion) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.UseDrug.searchByTime), params: Dictionary(), method: .post) { (success, code, content, string, error) in
            if success {
                if let data = content["data"] as? Dictionary<String,Any>,data.count > 0 {
                    
                    //排序
                    let format: DateFormatter = DateFormatter()
                    format.dateFormat = "HH:mm"
                    let resultArr = data.sorted(by: { (obj0, obj1) -> Bool in
                        let date0:Date = format.date(from: obj0.key)!
                        let date1:Date = format.date(from: obj1.key)!
                        //取与当前时间比较后的绝对值
                        let dateInt0: TimeInterval = date0.timeIntervalSinceReferenceDate
                        let dateInt1: TimeInterval = date1.timeIntervalSinceReferenceDate
                        return dateInt1 > dateInt0
                    })
                    
                    //模型
                    var dataList: Array<Any> = Array()
                    if resultArr.count > 0 {
                        for (idx,dict) in resultArr.enumerated() {
                            var temDict: Dictionary<String,Any> = Dictionary()
                            let value = dict.value
                            if let value = value as? Array<Any>,value.count > 0 {
                                let arr =  ZXRemindModel.mj_objectArray(withKeyValuesArray: value)
                                temDict["\(dict.key)"] = arr
                                dataList.append(temDict)
                            }
                        }
                    }
                    completion(true,code,dataList,error?.errorMessage ?? "")
                }else{
                    completion(true,code,nil,error?.errorMessage ?? "")
                }
            }else{
                completion(false,code,nil,error?.errorMessage ?? "")
            }
        }
    }
    
    //MARK: - 已添加提醒
    class func requestForDrugRemindList(completion:@escaping requestCompletion) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.UseDrug.drugRemindList), params: Dictionary(), method: .post) { (success, code, content, string, error) in
            if success {
                if let data = content["data"] as? Array<Any>,data.count > 0 {
                    let resultModelList = ZXRemindModel.mj_objectArray(withKeyValuesArray: data)
                    completion(true,code,resultModelList as? Array<ZXRemindModel>,error?.errorMessage ?? "")
                }else{
                    completion(false,code,nil,error?.errorMessage ?? "")
                }
            }else{
                completion(false,code,nil,error?.errorMessage ?? "")
            }
        }
    }
    
    //MARK: - 修改用药时间
    class func requestForModifyDrugTime(_ dict:Dictionary<String,Any>, completion:@escaping requestCompletion) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.UseDrug.modifyRemindTime), params: dict, method: .post) { (success, code, content, string, error) in
            if success {
                if code == ZXAPI_SUCCESS {
                    completion(true,code,nil,error?.errorMessage ?? "")
                }else{
                    completion(false,code,nil,error?.errorMessage ?? "")
                }
            }else{
                completion(false,code,nil,error?.errorMessage ?? "")
            }
        }
    }
    
    //MARK: - 是否推送
    class func requestForPush(_ dict:Dictionary<String,Any>, completion:@escaping requestCompletion) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.UseDrug.openDrugRemind), params: dict, method: .post) { (success, code, content, string, error) in
            if success {
                if code == ZXAPI_SUCCESS {
                    completion(true,code,nil,error?.errorMessage ?? "")
                }else{
                    completion(false,code,nil,error?.errorMessage ?? "")
                }
            }else{
                completion(false,code,nil,error?.errorMessage ?? "")
            }
        }
    }
}
