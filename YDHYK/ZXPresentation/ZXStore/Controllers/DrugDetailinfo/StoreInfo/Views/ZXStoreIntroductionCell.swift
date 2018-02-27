//
//  ZXStoreIntroductionCell.swift
//  YDHYK
//
//  Created by screson on 2017/10/18.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXStoreIntroductionCell: UITableViewCell {

    @IBOutlet weak var imgGroupIcon: UIImageView!
    @IBOutlet weak var lbGroupName: UILabel!
    @IBOutlet weak var lbGroupIntroduction: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbGroupName.font = UIFont.zx_titleFont(UIFont.zx_subTitleFontSize)
        self.lbGroupName.textColor = UIColor.zx_textColorTitle
        self.lbGroupIntroduction.font = UIFont.zx_bodyFont(UIFont.zx_bodyFontSize)
        self.lbGroupIntroduction.textColor = UIColor.zx_textColorTitle
        
        self.lbGroupName.text = ""
        self.lbGroupIntroduction.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reloadData(model: ZXStoreDetailModel?) {
        if let model = model {
            self.imgGroupIcon.kf.setImage(with: URL(string:ZXAPI.file(address: model.groupFiles)), placeholder: UIImage.Default.empty)
            self.lbGroupName.text = model.groupName
            //self.lbGroupIntroduction.text = model.groupProfile
            if let data = model.groupProfile.data(using: String.Encoding.utf8, allowLossyConversion: true) {
                let attrStr = try? NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                                   .characterEncoding: String.Encoding.utf8.rawValue],
                                                             documentAttributes: nil)
                if let attrStr = attrStr {
                    attrStr.addAttributes([NSAttributedStringKey.font: UIFont.zx_bodyFont(UIFont.zx_bodyFontSize),
                                           NSAttributedStringKey.foregroundColor: UIColor.zx_textColorTitle],
                                          range: NSMakeRange(0, attrStr.length))
                    let style = NSMutableParagraphStyle()
                    style.lineSpacing = 2
                    attrStr.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSMakeRange(0, attrStr.length))
                    self.lbGroupIntroduction.attributedText = attrStr
                } else {
                    self.lbGroupIntroduction.text = "无相关介绍"
                }
            } else {
                self.lbGroupIntroduction.text = "无相关介绍"
            }
        }
    }
    
}
