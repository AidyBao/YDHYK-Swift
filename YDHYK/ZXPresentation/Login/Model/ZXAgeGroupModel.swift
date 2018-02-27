//
//  ZXAgeGroupModel.swift
//  YDHYK
//
//  Created by 120v on 2017/11/3.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

enum ZXAgeGroupType {
    case Under_Twenty,Twenty_Thirty,Thirty_Fourty,Fourty_Fifty,Older_Fifty
    func typerValue() -> String {
        switch self {
        case .Under_Twenty:
            return "20岁以下"
        case .Twenty_Thirty:
            return "20-30岁"
        case .Thirty_Fourty:
            return "30-40岁"
        case .Fourty_Fifty:
            return "40-50岁"
        case .Older_Fifty:
            return "50岁以上"
        }
    }
}

@objcMembers class ZXAgeGroupModel: NSObject {

    var key: Int = -1
    var remark: String = ""
    var type: Int = -1
    var typeLabel: String = ""
    var ageId: Int = -1
    var value: String = ""
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["ageId":"id"];
    }
}
