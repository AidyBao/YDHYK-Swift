//
//  ZXDrugDetailCell.swift
//  YDHYK
//
//  Created by 120v on 2017/11/23.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXDrugDetailCell: UITableViewCell {
    
    static let ZXDrugDetailCellID: String = "ZXDrugDetailCell"
    
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var countLb: UILabel!
    @IBOutlet weak var remarkLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nameLb.textColor = UIColor.zx_textColorTitle
        self.countLb.textColor = UIColor.zx_textColorTitle
        self.remarkLb.textColor = UIColor.zx_textColorMark
        
        self.nameLb.font = UIFont.zx_titleFont
        self.countLb.font = UIFont.zx_titleFont
        self.remarkLb.font = UIFont.zx_markFont
    }
    
    func loadData(_ model: ZXRemindModel) {
        self.nameLb.text = model.drugName
        self.remarkLb.text = model.notes
        self.countLb.text = "\(model.dosage)\(model.unit)"
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
