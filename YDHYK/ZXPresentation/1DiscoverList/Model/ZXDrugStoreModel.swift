//
//  ZXDrugStoreModel.swift
//  YDHYK
//
//  Created by screson on 2017/11/3.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 加入会员城后-店铺数据
@objcMembers class ZXStoreShortModel: NSObject {
   var storeId = ""
   var name = ""            //店铺名称
   var headPortraitStr = "" //店铺logo

    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["storeId": "id"]
    }
}