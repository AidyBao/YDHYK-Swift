//
//  ZXDiscoverModel.swift
//  YDHYK
//
//  Created by screson on 2017/11/3.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 发现列表Model
@objcMembers class ZXDiscoverModel: NSObject {
    /**资讯ID*/
    var promotionId = ""
    /**标题*/
    var title = ""
    /**图片地址*/
    var homeIcon = ""//相对地址
    /**图片地址*/
    var homeIconStr = ""
    /**图片类型 1 小图 2大图*/
    var homeIconType = 1// 1 小图 2 大图
    /**图片地址*/
    var groupName = ""
    /**资讯类型 1促销 2资讯 3广告*/
    var promotionType = 1//1 2 3
    
    var promotionTypeStr = ""
    
    /**Content 详情接口内容*/
    var content = ""
    
    var sendDateStr = ""
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["promotionId": "id"]
    }
    //调整
    var  zx_publishDate: String {
        get {
            return sendDateStr.components(separatedBy: " ").first ?? ""
        }
    }
}
