//
//  ZXOrderMenuCollectionViewCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/6.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXOrderMenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbDot: UILabel!
    
    @IBOutlet weak var lbName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbName.font = UIFont.zx_titleFont(13)
        lbName.textColor = UIColor.zx_textColorTitle

        lbDot.font = UIFont.zx_titleFont(12)
        lbDot.backgroundColor = UIColor.zx_customBColor
        lbDot.layer.cornerRadius = 8
        lbDot.layer.masksToBounds = true
        self.setUnReadMessageCount(0)
    }
    
    func reload(title: String, image: UIImage) {
        lbName.text = title
        imgIcon.image = image
    }
    
    func setUnReadMessageCount(_ count: Int) {
        if count > 0 {
            lbDot.isHidden = false
        } else {
            lbDot.isHidden = true
        }
        lbDot.text = "\(count)"
    }

}
