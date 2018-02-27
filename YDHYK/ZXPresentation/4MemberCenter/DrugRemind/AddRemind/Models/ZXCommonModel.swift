//
//  ZXCommonModel.swift
//  YDHYK
//
//  Created by 120v on 2017/11/28.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

@objcMembers class ZXCommonModel: NSObject {
    var comId: Int = -1
    var key: String = ""
    var remark: String = ""
    var type: String = ""
    var typeLabel: String = ""
    var value: String = ""
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["comId":"id"]
    }
}
