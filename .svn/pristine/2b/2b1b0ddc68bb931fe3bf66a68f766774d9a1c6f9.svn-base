//
//  ZXReportListCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXReportListCell: UITableViewCell {

    @IBOutlet weak var backContentView: UIView!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbSex: UILabel!
    @IBOutlet weak var lbAge: UILabel!
    @IBOutlet weak var lbAbnormal: UILabel!
    @IBOutlet weak var imgReport: UIImageView!
    static let height: CGFloat = 130
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.backContentView.layer.masksToBounds = true
        self.backContentView.layer.cornerRadius = 5
        
        self.lbTime.font = UIFont.zx_titleFont(14)
        self.lbSex.font = UIFont.zx_titleFont(14)
        self.lbAge.font = UIFont.zx_titleFont(14)
        self.lbAbnormal.font = UIFont.zx_titleFont(14)
        
        self.lbTime.textColor = UIColor.zx_textColorTitle
        self.lbSex.textColor = UIColor.zx_textColorTitle
        self.lbAge.textColor = UIColor.zx_textColorTitle
        self.lbAbnormal.textColor = UIColor.white
        
        self.lbAbnormal.layer.masksToBounds = true
        self.lbAbnormal.layer.cornerRadius = 10
        
        self.imgReport.backgroundColor = UIColor.zx_borderColor
        self.imgReport.layer.borderColor = UIColor.zx_subTintColor.cgColor
        self.imgReport.layer.borderWidth = 1

        self.lbTime.text = ""
        self.lbSex.text = ""
        self.lbAge.text = ""
        self.lbAbnormal.text = ""
    }
    
    func reloadData(model: ZXReportListModel?) {
        if let model = model {
            self.lbTime.text = model.zx_dateDescription
            self.lbSex.text = model.sexStr
            self.lbAge.text = "\(model.age)"
            self.imgReport.kf.setImage(with: URL.init(string: model.imgStr), placeholder: UIImage.Default.empty)
            if model.abnormalNum > 0 {
                self.lbAbnormal.backgroundColor = UIColor.zx_colorRGB(255, 66, 0, 1)
                self.lbAbnormal.text = "\(model.abnormalNum)个异常点"
            } else {
                self.lbAbnormal.backgroundColor = UIColor.zx_tintColor
                self.lbAbnormal.text = "无异常点"
            }
        }
    }
    
}
