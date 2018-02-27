//
//  ZXDiscoverSamllTypeCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/3.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXDiscoverSamllTypeCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbMediaName: UILabel!
    
    @IBOutlet weak var imgIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        lbTitle.font = UIFont.init(name: "PingFangSC-Medium", size: UIFont.zx_titleFontSize)
        lbTitle.textColor = UIColor.zx_textColorBody
        
        lbType.font = UIFont.zx_titleFont(UIFont.zx_bodyFontSize - 1)
        lbType.textColor = UIColor.zx_tintColor
        
        lbMediaName.font = UIFont.zx_titleFont(UIFont.zx_bodyFontSize - 1)
        lbMediaName.textColor = UIColor.lightGray
        
        imgIcon.backgroundColor = UIColor.zx_borderColor
        self.clearText()
    }
    
    fileprivate func clearText() {
        lbTitle.text = ""
        lbType.text  = ""
        lbMediaName.text = ""
        imgIcon.image  = nil
    }
    
    func reloadData(model: ZXDiscoverModel?) {
        self.clearText()
        if let model = model {
            lbTitle.text = model.title
            lbType.text  = model.promotionTypeStr
            lbMediaName.text = model.groupName
            imgIcon.kf.setImage(with: URL.init(string: model.homeIconStr), placeholder: UIImage.Default.empty)
        }
    }
}
