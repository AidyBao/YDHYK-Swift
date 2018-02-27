//
//  ZXUserInfoTextHeaderCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/6.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// Info Header
class ZXUserInfoTextHeaderCell: UITableViewCell {

    @IBOutlet weak var lbLeftText: UILabel!
    @IBOutlet weak var lbRightText: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
}
