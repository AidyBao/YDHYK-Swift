//
//  ZXTemplateItemCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/22.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXTemplateItemCell: UITableViewCell {

    @IBOutlet weak var imgCheckBox: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbName.font = UIFont.zx_subTitleFont
        self.lbName.textColor = UIColor.zx_textColorTitle
        self.lbName.highlightedTextColor = UIColor.zx_tintColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.lbName.isHighlighted = selected
        self.imgCheckBox.isHighlighted = selected
    }
    
}
