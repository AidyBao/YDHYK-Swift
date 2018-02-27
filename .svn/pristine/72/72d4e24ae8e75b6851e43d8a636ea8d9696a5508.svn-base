//
//  ZXDrugListCell.swift
//  YDHYK
//
//  Created by 120v on 2017/11/23.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXDrugListCell: UITableViewCell {
    
    static let ZXDrugListCellID: String = "ZXDrugListCell"
    
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var countLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.nameLb.font = UIFont.zx_titleFont
        self.nameLb.textColor = UIColor.zx_textColorTitle
        
        self.countLb.font = UIFont.zx_titleFont
        self.countLb.textColor = UIColor.zx_textColorTitle
    }
    
    func loadData(_ model: ZXRemindModel) {
        self.nameLb.text = model.drugName
        
        self.countLb.text = "\(model.dosage)\(model.unit)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
