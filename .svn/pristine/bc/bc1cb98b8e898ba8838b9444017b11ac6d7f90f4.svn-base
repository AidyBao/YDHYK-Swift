//
//  ZXDrugRemindCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/15.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXDrugRemindCell: UITableViewCell {

    @IBOutlet weak var topOffset: NSLayoutConstraint!
    @IBOutlet weak var lbDrugName: UILabel!
    @IBOutlet weak var lbUsage: UILabel!
    @IBOutlet weak var lbRemark: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbUsage.text = ""
        self.lbDrugName.text = ""
        self.lbRemark.text = ""
        self.showRemark(false)
    }

    func reloadData(model: ZXTakeMedicineModel?) {
        self.lbUsage.text = ""
        self.lbDrugName.text = ""
        self.lbRemark.text = ""
        self.showRemark(false)
        if let model = model {
            self.lbUsage.text = model.zx_dosageDesc
            self.lbDrugName.text = model.drugName
            if model.notes.isEmpty {
                self.lbRemark.text = model.notes
                self.showRemark(true)
            }
        }
    }
    
    fileprivate func showRemark(_ show: Bool) {
        if show {
            self.topOffset.constant = 5
            self.lbRemark.isHidden = false
        } else {
            self.topOffset.constant = 12
            self.lbRemark.isHidden = true
        }
    }
}
