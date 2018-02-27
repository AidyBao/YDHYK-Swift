//
//  ZXPrescriptionCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/9.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXPrescriptionCell: UITableViewCell {

    static let height: CGFloat = 277
    
    @IBOutlet weak var imgPrescription: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.imgPrescription.backgroundColor = UIColor.zx_borderColor
        self.lbTitle.font = UIFont.zx_subTitleFont
        self.lbTitle.textColor = UIColor.zx_textColorTitle
        self.lbTime.font = UIFont.zx_titleFont(11)
        self.lbTime.textColor = UIColor.zx_textColorMark
        self.imgPrescription.image = nil
        self.lbTitle.text = nil
        self.lbTime.text = nil
    }
    
    func reloadData(model: ZXPrescriptionModel?) {
        self.imgPrescription.image = nil
        self.lbTitle.text = nil
        self.lbTime.text = nil
        if let model = model {
            self.imgPrescription.kf.setImage(with: model.zx_imageUrl)
            self.lbTitle.text = model.title
            self.lbTime.text = model.uploadDateStr
        }
    }
}
