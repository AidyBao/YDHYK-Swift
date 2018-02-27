//
//  ZXItemInputModel.swift
//  YDHYK
//
//  Created by screson on 2017/11/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 检查项值类型
enum ZXItemValueType: UInt {
    case valueType      = 1 //值
    case yyTextType     = 2 //阴性 阳性
    case plus_minusType = 3 //+/-
    case none = 99
}


/// 用于储存本地录入的检查项
/**新增化验单-检查项 详细模型*/
@objcMembers class ZXCheckItemDetailModel: NSObject {
    var referenceValueTypeKey: UInt = 99 //参考值类型 1 2 3
    var zx_referenceValueTypeKey: ZXItemValueType {
        get {
            if let type = ZXItemValueType(rawValue: self.referenceValueTypeKey) {
                return type
            }
            return .none
        }
    }
    var id = ""
    //var itemId = ""
    var itemName = ""
    /** 区间值：最小参考值*/
    var referenceMinValue = ""
    /** 区间值：最大参考值*/
    var referenceMaxValue = ""
    /**【数值】区间-结果值*/
    var resultValue = ""
    /** 阴性/阳性 参考值 0阴性 1阳性*/
    var referenceNegativePositive = ""
    /** 阴性/阳性 结果值 0阴性 1阳性*/
    var resultNegativePositive = ""
    /** +/- 参考值  1+ 0-*/
    var referenceAddSub = ""
    /** +/- 结果值  1+ 0-*/
    var resultAddSub = ""
    
    //调整
    var resultValueTypeKey: UInt = 99 //类型 1 2 3
    var zx_resultValueTypeKey: ZXItemValueType { //用于录入时比对
        get {
            if let type = ZXItemValueType(rawValue: self.resultValueTypeKey) {
                return type
            }
            return .none
        }
    }
    var unusualDescription = "" //异常描述 【无：空】
    var sectionRefrenceValueDesc: String {
        return "\(referenceMinValue)-\(referenceMaxValue)"
    } //区间参考值描述
    var strReferenceAddSub: String {
        get {
            if referenceAddSub == "1" {
                return "+"
            } else if referenceAddSub == "0" {
                return "-"
            }
            return ""
        }
    } //录入的 +/- 参考值String
    var strResultAddSub: String {
        get {
            if resultAddSub == "1" {
                return "+"
            } else if resultAddSub == "0" {
                return "-"
            }
            return ""
        }
    } //录入的 +/- 结果值String
    var strResultNegativePositive: String {
        get {
            if referenceNegativePositive == "1" {
                return "阳性"
            } else if referenceNegativePositive == "0" {
                return "阴性"
            }
            return ""
        }
    } //录入的 阴性/阳性 参考值String
    var strReferenceNegativePositive: String {
        get {
            if resultNegativePositive == "1" {
                return "阳性"
            } else if resultNegativePositive == "0" {
                return "阴性"
            }
            return ""
        }
    } //录入的 阴性/阳性 结果值String
    
    /**不序列化*/
    override static func mj_ignoredPropertyNames() -> [Any]! {
        return ["unusualDescription",
                "sectionRefrenceValueDesc",
                "resultValueTypeKey",
                "strReferenceAddSub",
                "strResultAddSub",
                "strResultNegativePositive",
                "strReferenceNegativePositive",
                "zx_resultValueTypeKey",
                "zx_referenceValueTypeKey"]
    }
}