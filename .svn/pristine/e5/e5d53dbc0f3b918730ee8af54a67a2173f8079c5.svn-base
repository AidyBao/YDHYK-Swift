//
//  ZXUCMarkedDrugCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/9.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 个人中心-收藏药品Cell
class ZXUCMarkedDrugCell: UITableViewCell {

    static let heigt: CGFloat = 115
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbDrugName: UILabel!
    @IBOutlet weak var lbDrugSpecs: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        imgIcon.backgroundColor = UIColor.clear
        
        lbDrugName.font = UIFont.zx_subTitleFont
        lbDrugName.textColor = UIColor.zx_textColorTitle
        
        lbDrugSpecs.font = UIFont.zx_titleFont(13)
        lbDrugSpecs.textColor = UIColor.zx_textColorMark
        
        lbPrice.font = UIFont.zx_subTitleFont(UIFont.zx_subTitleFontSize + 1)
        lbPrice.textColor = UIColor.zx_colorRGB(245, 92, 30, 1)
        
    }
    
    func reloadData(model: ZXUCMarkedDrugModel?) {
        imgIcon.image = nil
        lbDrugName.text = nil
        lbDrugSpecs.text = nil
        lbPrice.text = nil
        if let model = model {
            imgIcon.kf.setImage(with: URL.init(string: model.attachFilesStr))
            //富文本
            let attachment = NSTextAttachment.init(data: nil, ofType: nil)
            var image = #imageLiteral(resourceName: "otc")
            if model.isPrescription == 1 {
                image = #imageLiteral(resourceName: "rx")
            }
            attachment.image = image
            attachment.bounds = CGRect(x: 0, y: -3, width: 31, height: 15)
            let textImage = NSAttributedString.init(attachment: attachment)
            let name = " \(model.drugName)"
            let attrName = NSMutableAttributedString.init(string: name)
            attrName.insert(textImage, at: 0)
            lbDrugName.attributedText = attrName
            
            lbDrugSpecs.text = model.packingSpec
            lbPrice.text = "\(model.price)".zx_priceString()
        }
    }
    
}
