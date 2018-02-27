//
//  ZXRemindListCell.swift
//  YDHYK
//
//  Created by 120v on 2017/11/24.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

protocol ZXRemindListRootCellDelegate: NSObjectProtocol {
    func didListRootCellSwich(_ sender: UISwitch,_ model: ZXRemindModel?)
}

class ZXRemindListRootCell: UITableViewCell {
    
    static let ZXRemindListRootCellID: String = "ZXRemindListRootCell"
    weak var delegate: ZXRemindListRootCellDelegate?
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var descLb: UILabel!
    @IBOutlet weak var remindSwicher: UISwitch!
    var model: ZXRemindModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nameLb.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.nameLb.textColor = UIColor.zx_textColorTitle
        
        self.descLb.textColor = UIColor.zx_textColorBody
        self.descLb.font = UIFont.zx_bodyFont
        
        self.remindSwicher.clipsToBounds = true
        self.nameLb.clipsToBounds = true
        self.descLb.clipsToBounds = true
    }
    
//    func loadData(_ dict: Dictionary<String,Any>) {
//        let values = dict.values
//
//    }
    
    
    func loadData(_ mod: ZXRemindModel) {

        self.model = mod

        self.remindSwicher.isHidden = false
        self.nameLb.text = mod.drugName
        self.descLb.text = mod.remindContent
        if mod.isPush == 1 {
            self.remindSwicher.isOn = true
        }else if mod.isPush == 0 {
            self.remindSwicher.isOn = false
        }
    }
    
    @IBAction func remindSwitchAction(_ sender: UISwitch) {
        if self.delegate != nil {
            self.delegate?.didListRootCellSwich(sender, self.model)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
