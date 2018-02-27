//
//  ZXMemberCardModel.swift
//  YDHYK
//
//  Created by 120v on 2017/11/6.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

@objcMembers class ZXMemberCardModel: NSObject {
    var uid: Int = -1
    var groupId: Int = -1
    var groupName: String = ""
    var drugstoreId: Int = -1
    var drugstoreName: String = ""
    var memberId: Int = -1
    var memberNo: Int = -1
    var memberName: String = ""
    var memberTel: String = ""
    var memberBirthday: String = ""
    var memberSex: Int = -1
    var memberMobileSystemType: String = ""
    var joinDate: String = ""
    var sourceType: String = ""
    var firstEnterDate: String = ""
    var lastEnterDate: String = ""
    var lastOrderId: Int = -1
    var lastOrderDate: String = ""
    var buyTimes: Int = -1
    var buyMoney: Int = -1
    var integral: Int = 0
    var userId: Int = -1
    var userName: String = ""
    var userAccount: String = ""
    var memberDeviceToken: String = ""
    var status: String = ""
    var couponNum: Int = 0
    var headPortrait: String = ""
    var drugstoreTel: String = ""
    var headPortraitStr: String = ""
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["uid":"id"]
    }
}
