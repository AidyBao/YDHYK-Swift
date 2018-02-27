//
//  ZXReportDetailCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/21.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 化验单详情-Cell
class ZXReportDetailCell: UITableViewCell {

    @IBOutlet weak var lbItemName: UILabel!
    @IBOutlet weak var lbUnUsualDesc: ZXUILabel!
    @IBOutlet weak var lbRefrencValue: UILabel!
    @IBOutlet weak var lbResubltValue: UILabel!
    @IBOutlet weak var nameOffsetToRefrenceValue: NSLayoutConstraint!//有异常描述 >= 50 ,无异常描述 >= 6
    
    @IBOutlet weak var abnormalViewWidth: NSLayoutConstraint!// 44 30
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbItemName.textColor = UIColor.zx_textColorTitle
        self.lbItemName.font = UIFont.zx_titleFont
        
        self.lbRefrencValue.textColor = UIColor.zx_textColorTitle
        self.lbRefrencValue.font = UIFont.zx_subTitleFont
        
        self.lbResubltValue.textColor = UIColor.zx_textColorTitle
        self.lbRefrencValue.highlightedTextColor = UIColor.zx_customBColor
        self.lbResubltValue.font = UIFont.zx_subTitleFont
        
        self.lbUnUsualDesc.textColor = UIColor.white
        self.lbUnUsualDesc.backgroundColor = UIColor.zx_customBColor
        self.lbUnUsualDesc.font = UIFont.zx_titleFont(11)
        self.lbUnUsualDesc.isHidden = true
    }
    
    func reloadData(model:ZXCheckItemShortModel?) {
        if let model = model {
            self.lbItemName.text = model.itemName
            self.lbRefrencValue.text = model.referenceValue
            self.lbResubltValue.text = model.checkValue
            if model.isAbnormal == 1 {
                self.lbUnUsualDesc.isHidden = false
                if model.abnormalStatus.count <= 1 {
                    abnormalViewWidth.constant = 30
                } else {
                    abnormalViewWidth.constant = 40
                }
                lbUnUsualDesc.text = model.abnormalStatus
                lbResubltValue.isHighlighted =  true
                nameOffsetToRefrenceValue.constant = 50
            } else {
                self.lbUnUsualDesc.isHidden = true
                lbUnUsualDesc.text = ""
                lbResubltValue.isHighlighted =  false
                nameOffsetToRefrenceValue.constant = 6

            }
        }
    }
}
