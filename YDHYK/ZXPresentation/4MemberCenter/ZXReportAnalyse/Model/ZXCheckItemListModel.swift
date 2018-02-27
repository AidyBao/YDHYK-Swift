//
//  ZXCheckItemListModel.swift
//  YDHYK
//
//  Created by screson on 2017/11/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/**新增化验单-检查项 简单模型*/
@objcMembers class ZXCheckItemListModel: NSObject {
    var id = ""
    var itemName = "" {
        didSet {
            pinyin = itemName.zx_pinyin(removeSpace: true)
            let tempP = itemName.zx_pinyin()
            let arrText = tempP.components(separatedBy: " ")
            var letters = ""
            for text in arrText {
                letters.append(text.substring(to: 1))
            }
            firstWordLetters = letters
        }
    }
    var referenceValueTypeKey: UInt = 99 // 1 2 3
    var zx_refrenceValutType: ZXItemValueType {
        get {
            if let type = ZXItemValueType(rawValue: 1) {
                return type
            }
            return .none
        }
    }
    
    //用于搜索
    fileprivate var pinyin = ""
    var zx_pinyin: String {
        get {
            return pinyin
        }
    }
    fileprivate var firstWordLetters = "" //首字母 用于搜索
    var zx_firstWordLetters: String {
        get {
            return firstWordLetters
        }
    }
}
