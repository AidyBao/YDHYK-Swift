//
//  ZXSettingTimeCell.swift
//  YDHYK
//
//  Created by 120v on 2017/11/24.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXSettingTimeCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLb: UILabel!
    @IBOutlet weak var qtyLb: UILabel!
    
    static let ZXSettingTimeCellID: String = "ZXSettingTimeCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 14.0
        self.layer.masksToBounds = true
    }
    
    func loadData(_ model: ZXAddTimeModel) {
        let startIndex = model.drugTime.index(model.drugTime.startIndex, offsetBy: 11)
        let endIndex = model.drugTime.index(model.drugTime.startIndex, offsetBy: 16)
        let timeStr = model.drugTime.substring(with: startIndex..<endIndex)
        self.timeLb.text = timeStr
        
        self.qtyLb.text = "第\(model.addQty)次"
    }

}
