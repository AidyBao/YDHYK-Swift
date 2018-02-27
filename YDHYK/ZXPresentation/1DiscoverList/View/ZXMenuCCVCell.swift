//
//  ZXMenuCCVCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/3.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXMenuCCVCell: UICollectionViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.lbName.textColor = .white
        self.lbName.font = UIFont.zx_titleFont(UIFont.zx_subTitleFontSize)
    }

}
