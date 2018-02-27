//
//  ZXNoCardHearder.swift
//  YDHYK
//
//  Created by 120v on 2017/11/7.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXNoCardHearder: UITableViewHeaderFooterView {
    
    static let ZXNoCardHearderID: String = "ZXNoCardHearder"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.zx_backgroundColor
        self.clipsToBounds = true
    }
}
