//
//  ZXAnalyseResultCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/21.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 化验单分析异常结果说明
class ZXAnalyseResultCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbResult: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbName.font = UIFont.zx_subTitleFont
        self.lbStatus.font = UIFont.zx_subTitleFont
        self.lbResult.font = UIFont.zx_bodyFont
        
        self.lbName.textColor = UIColor.zx_textColorTitle
        self.lbStatus.textColor = UIColor.zx_customBColor
        self.lbResult.textColor = UIColor.zx_colorRGB(56, 62, 67, 1.0)
        self.lbName.text = ""
        self.lbStatus.text   = ""
        self.lbResult.text   = ""
    }
    
    func reloadData(model: ZXAnalyseResultItem?) {
        if let model = model {
            self.lbName.text = model.itemName
            self.lbStatus.text   = model.resultValue
            self.lbResult.text   = model.abnormalReason
        }
    }
    
}
