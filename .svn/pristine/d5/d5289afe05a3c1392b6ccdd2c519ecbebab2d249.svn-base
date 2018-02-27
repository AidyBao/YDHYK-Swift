//
//  ZXItemTypeModel.swift
//  YDHYK
//
//  Created by screson on 2017/11/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 检查项选择类型
///
enum ZXItemType {
    case choose //选择值 如 阴/阳 +/-
    case input  //区间值 输入
    case none
}


/// 检查项录入类型
@objcMembers class ZXItemInputModel: NSObject {
    var name = ""   //如：数值、+/- 阴阳
    var type: ZXItemType = .none
    var chooseList: Array<String> = [] //供选择数据 【区间值时为空】
    var zxValueType: ZXItemValueType {
        get {
            if chooseList.count > 0,let first = chooseList.first {
                if first == "+" || first == "-" {
                    return .plus_minusType
                } else {
                    return .yyTextType
                }
            }
            return .valueType
        }
    }
}
