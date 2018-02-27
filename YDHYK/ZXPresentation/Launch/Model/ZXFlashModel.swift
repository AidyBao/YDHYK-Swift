//
//  ZXFlashModel.swift
//  YDHYK
//
//  Created by 120v on 2017/11/2.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

@objcMembers class ZXFlashModel: NSObject {
    
    var ageGroups: Int = -1
    var attachFile: String = ""
    var attachFileStr: String = ""
    var endDate: String = ""
    var uid: Int = -1
    var remark: String = ""
    var sex: Int = -1
    var status: String = ""
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["uid":"id"]
    }
}