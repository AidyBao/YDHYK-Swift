//
//  ZXReportDetailAgeSexCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/21.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXReportDetailAgeSexCell: UITableViewCell {

    @IBOutlet weak var lbSexTitle: UILabel!
    @IBOutlet weak var lbSex: UILabel!
    @IBOutlet weak var lbAgeTitle: UILabel!
    @IBOutlet weak var lbAge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lbSexTitle.textColor = UIColor.zx_textColorTitle
        self.lbSexTitle.font = UIFont.zx_subTitleFont
        self.lbAgeTitle.textColor = UIColor.zx_textColorTitle
        self.lbAgeTitle.font = UIFont.zx_subTitleFont
        
        self.lbSex.textColor = UIColor.zx_textColorTitle
        self.lbSex.font = UIFont.zx_subTitleFont
        self.lbAge.textColor = UIColor.zx_textColorTitle
        self.lbAge.font = UIFont.zx_subTitleFont
        self.lbSex.text = ""
        self.lbAge.text = ""
    }

    func reloaData(patient: ZXPatientInfo?) {
        if let patient = patient {
            self.lbSex.text = patient.sexStr
            self.lbAge.text = "\(patient.age)"
        }
    }
    
}
