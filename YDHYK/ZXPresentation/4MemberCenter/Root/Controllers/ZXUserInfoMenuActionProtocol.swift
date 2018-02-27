//
//  ZXUserInfoMenuActionProtocol.swift
//  YDHYK
//
//  Created by screson on 2017/11/6.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

enum ZXUserMenuActionType {
    case messageList
    case setting
    case editInfo
    case none
}

protocol ZXUserInfoMenuActionProtocol: class {
    func zxUserInfoMenuHeaderAction(type t:ZXUserMenuActionType)
    func zxUserInfoMenuOrderMenuAction(at index: Int)
    func zxUserInfoMenuToolsMenuAction(at index: Int)
}
