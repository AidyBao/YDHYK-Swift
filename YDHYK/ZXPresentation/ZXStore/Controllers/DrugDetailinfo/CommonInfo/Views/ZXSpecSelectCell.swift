//
//  ZXSpecSelectCell.swift
//  YDHYK
//
//  Created by screson on 2017/10/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXSpecSelectCell: UITableViewCell {

    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var lbLeftText: UILabel!
    @IBOutlet weak var lbRightText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbLeftText.font = UIFont.zx_titleFont(UIFont.zx_bodyFontSize)
        self.lbLeftText.textColor = UIColor.zx_textColorMark
        
        self.lbRightText.font = UIFont.zx_bodyFont(UIFont.zx_bodyFontSize)
        self.lbRightText.textColor = UIColor.zx_textColorTitle
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
