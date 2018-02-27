//
//  ZXCheckSelectCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/24.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXCheckSelectCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgCheck: UIImageView!
    var showCheckImage = true
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        imgCheck.isHidden = true
        self.lbName.font = UIFont.zx_subTitleFont
        self.lbName.textColor = UIColor.zx_textColorTitle
        self.lbName.highlightedTextColor = UIColor.zx_tintColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if showCheckImage {
            lbName.isHighlighted = selected
            imgCheck.isHidden = !selected
        } else {
            imgCheck.isHidden = true
        }
    }
    
}
