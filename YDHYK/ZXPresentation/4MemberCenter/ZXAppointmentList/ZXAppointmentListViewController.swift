//
//  ZXAppointmentListViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/6.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 我的预约-暂时为空
class ZXAppointmentListViewController: ZXUIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "预约"
        // Do any additional setup after loading the view.
        ZXEmptyView.show(in: self.view, type: .noData, text: "您还没有预约数据")
    }

}
