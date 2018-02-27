//
//  ZXSmartToolCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/13.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXSmartToolCell: UITableViewCell {

    @IBOutlet weak var zxContentView: UIView!
    @IBOutlet weak var imgLeftIcon: UIImageView!
    @IBOutlet weak var imgRightIcon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSublTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        self.zxContentView.backgroundColor = .white
        self.zxContentView.layer.shadowRadius = 10
        self.zxContentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.zxContentView.layer.shadowOpacity = 0.25
        self.zxContentView.layer.cornerRadius = 5
        
        self.lbTitle.font = UIFont.zx_titleFont(20)
        self.lbTitle.textColor = UIColor.zx_textColorTitle
        
        imgLeftIcon.image = #imageLiteral(resourceName: "h_icon-clock")
        imgRightIcon.image = #imageLiteral(resourceName: "h_smartTool1")
        
        self.lbSublTitle.font = UIFont.zx_titleFont(13)
        self.lbSublTitle.textColor = UIColor.zx_textColorBody
    }
    
    func reloadData(by index: Int) {
        if index == 0 {
            lbTitle.text = "用药提醒"
            lbSublTitle.text = "定个时间，我们会提醒您按时服药"
            imgLeftIcon.image = #imageLiteral(resourceName: "h_icon-list")
            imgRightIcon.image = #imageLiteral(resourceName: "h_smartTool2")
        } else {
            lbTitle.text = "化验单分析"
            lbSublTitle.text = "扫描化验单，分析项目的异常情况"
            imgLeftIcon.image = #imageLiteral(resourceName: "h_icon-clock")
            imgRightIcon.image = #imageLiteral(resourceName: "h_smartTool1")
        }
    }
}
