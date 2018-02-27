//
//  ZXSpecCollectionViewCell.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/6/1.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXSpecCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbInfo: ZXUILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lbInfo.font = UIFont.zx_titleFont(UIFont.zx_bodyFontSize - 1)
        self.lbInfo.textColor = UIColor.zx_customBColor
        self.lbInfo.highlightedTextColor = UIColor.white
        self.lbInfo.isHighlighted = false
        self.lbInfo.backgroundColor = UIColor.white
        self.lbInfo.borderColor = UIColor.zx_customBColor
        self.lbInfo.borderWidth = 1.0
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.lbInfo.isHighlighted = true
                self.lbInfo.backgroundColor = UIColor.zx_customBColor
                self.lbInfo.borderColor = UIColor.clear
            }else{
                self.lbInfo.isHighlighted = false
                self.lbInfo.backgroundColor = UIColor.white
                self.lbInfo.borderColor = UIColor.zx_customBColor
            }
        }
    }
    
    func reloadData(_ model:ZXDrugSpecModel?) {
        self.lbInfo.text = ""
        if let model = model {
            self.lbInfo.text = model.name
        }
    }
}

