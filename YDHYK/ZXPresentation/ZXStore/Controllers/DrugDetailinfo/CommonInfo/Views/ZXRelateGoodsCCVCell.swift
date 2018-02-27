//
//  ZXRelateGoodsCCVCell.swift
//  YDHYK
//
//  Created by screson on 2017/10/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXRelateGoodsCCVCell: UICollectionViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbName_Spec: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgIcon?.image = UIImage.Default.empty

        self.lbName_Spec.font = UIFont.zx_bodyFont(UIFont.zx_bodyFontSize - 1)
        self.lbName_Spec.textColor = UIColor.zx_textColorMark
        
        self.lbPrice.font = UIFont.boldSystemFont(ofSize: UIFont.zx_bodyFontSize)
        self.lbPrice.textColor = UIColor.zx_textColorTitle
    }
    
    func reloadData(model: ZXDrugModel) {
        self.imgIcon.image = nil
        
        if let first = model.attachFilesStrs.first,let url =  URL(string: ZXAPI.file(address: first)) {
            self.imgIcon.kf.setImage(with: url, placeholder: UIImage.Default.empty)
        } else {
            self.imgIcon.image = UIImage.Default.empty
        }
        self.lbName_Spec.text = "\(model.drugName) \(model.packingSpec)"
        self.lbPrice.text = "\(model.zx_truePrice)".zx_priceString()
    }

}