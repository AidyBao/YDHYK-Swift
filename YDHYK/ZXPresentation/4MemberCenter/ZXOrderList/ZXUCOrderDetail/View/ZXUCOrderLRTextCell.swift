//
//  ZXUCOrderLRTextCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/8.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 支付类型、订单号、收货人、地址等信息
class ZXUCOrderLRTextCell: UITableViewCell {

    @IBOutlet weak var lbLeftText: UILabel!
    @IBOutlet weak var lbRightText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbLeftText.font = UIFont.zx_titleFont(13)
        self.lbLeftText.textColor = UIColor.zx_textColorTitle
        
        self.lbRightText.font = UIFont.zx_titleFont(13)
        self.lbRightText.textColor = UIColor.zx_textColorMark
        self.lbRightText.numberOfLines = 2
        self.lbRightText.adjustsFontSizeToFitWidth = true
        
        self.lbLeftText.text = ""
        self.lbRightText.text = ""
    }    
}
