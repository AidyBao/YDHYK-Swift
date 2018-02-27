//
//  ZXReportListModel.swift
//  YDHYK
//
//  Created by screson on 2017/11/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
/**化验单列表*/
@objcMembers class ZXReportListModel: NSObject {
    var reportId = ""
    var age: Int = 0
    var sex: Int = 0
    var sexStr = ""
    /**是否异常 0否   1是*/
    var isAbnormal: Int = 0
    /**异常数目*/
    var abnormalNum: Int = 0
    var createDate: Int64 = 0   //毫秒数
    var createDateStr = ""      //字符串
    /**相对路径*/
    //var img
    /**绝对路径*/
    var imgStr = ""
    // var Int  status//所有接口 0 作废 1 有效
    /**日期描述 今天+Time  昨天+Time 日期*/
    var zx_dateDescription: String {
        get {
            let currentMillSeconds = ZXDateUtils.current.millisecond()
            let dis = currentMillSeconds - self.createDate
            let hour = (dis / (60 * 60 * 1000))
            if hour < 24 {//今天+Time
                return "今天 " + ZXDateUtils.millisecond.time(self.createDate, withSecond: false)
            } else if (hour >= 24 && hour < 48){//昨天+Time
                return "昨天 " + ZXDateUtils.millisecond.time(self.createDate, withSecond: false)
            } else {
                return ZXDateUtils.millisecond.dateformat(self.createDate, format: "MM-dd HH:mm")
            }
        }
    }
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["reportId": "id"]
    }
}
