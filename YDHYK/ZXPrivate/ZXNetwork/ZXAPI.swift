//
//  ZXAPI.swift
//  ZXStructs
//
//  Created by screson on 2017/4/14.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

enum ZXWebPageType: Int {
    case floorIds = 1   //楼层
    case activity = 2   //活动
}

class ZXAPI: NSObject {
    final class func api(address path:String!) -> String {
        var strAPIURL = ZXURLConst.Api.url + ":" + ZXURLConst.Api.port
        if path.hasPrefix("/") {
            strAPIURL += path
        }else {
            strAPIURL += "/" + path
        }
        return strAPIURL
    }
    
    final class func file(address path:String!) -> String {
        var strAPIURL = ZXURLConst.Resource.url + ":" + ZXURLConst.Resource.port
        if path.hasPrefix("/") {
            strAPIURL += path
        }else {
            strAPIURL += "/" + path
        }
        return strAPIURL
    }
    
    final class func store(address path:String!) -> String {
        //var strAPIURL = ZXAPIConst.Store.url//接口地址合并
        var strAPIURL = ZXURLConst.Api.url + ":" + ZXURLConst.Api.port
        if path.hasPrefix("/") {
            strAPIURL += path
        }else {
            strAPIURL += "/" + path
        }
        return strAPIURL
    }
    
    final class func activity(_ sId:String,type:ZXWebPageType) -> String {
        var strWebURL = ZXURLConst.Web.url
        var arrParams = [String]()
        arrParams.append("id=\(sId)")
        arrParams.append("flag=\(type.rawValue)")
        arrParams.append("pageSize=\(ZX.PageSize)")
        arrParams.append("pageNum=1")
        arrParams.append("memberId=\(ZXUser.user.memberId)")
        arrParams.append("token=\(ZXUser.user.userToken)")
        
        if arrParams.count > 0 {
            strWebURL.append("?\(arrParams.joined(separator: "&"))")
            strWebURL.append("&uTime=\(NSUUID.init().uuidString)")
        }else{
            strWebURL.append("?uTime=\(NSUUID.init().uuidString)")
        }
        print(strWebURL)
        return strWebURL
    }
}
