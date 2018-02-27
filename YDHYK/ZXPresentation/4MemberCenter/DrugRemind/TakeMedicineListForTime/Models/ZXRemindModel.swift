//
//  ZXRemindModel.swift
//  YDHYK
//
//  Created by 120v on 2017/11/23.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

@objcMembers class ZXRemindModel: NSObject {
    var remindId: Int           = -1
    var memberId: Int           = -1
    var drugName: String        = ""
    var dosage: Int             = 0
    var unit: String            = ""
    var notes: String           = ""
    var cycle: Int              = -1
    var cycleValue: String      = ""
    var isPush: Int             = -1
    var status: String          = ""
    var pushDate: String        = ""
    var detailId: Int           = -1
    var remindContent: String   = ""
    var isAdd: String           = ""
    var isPushStr: String       = ""
    var pushDateStr: String     = ""
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["remindId":"id"]
    }
}
