//
//  ZXHistoryOrderCell.swift
//  YDHYK
//
//  Created by 120v on 2017/11/28.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXHistoryOrderCell: UITableViewCell {

    static let ZXHistoryOrderCellID: String = "ZXHistoryOrderCell"
    
    @IBOutlet weak var nameLb: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.nameLb.textColor = UIColor.zx_textColorBody
    }
    
    func loadData(_ model: ZXHistoryOrderDetailModel) {
        self.nameLb.text = model.drugName
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
