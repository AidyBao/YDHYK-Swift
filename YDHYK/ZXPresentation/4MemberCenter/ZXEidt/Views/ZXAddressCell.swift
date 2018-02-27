//
//  ZXAddressCell.swift
//  YDHYK
//
//  Created by 120v on 2017/11/15.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

protocol ZXAddressCellDelegate:NSObjectProtocol {
    func didSelectedAddressAction(_ sender:UIButton,_ model: ZXAddressModel) -> Void
}

class ZXAddressCell: UITableViewCell {
    
    struct ToolButtonTag {
        static let statusBtnTag: NSInteger  = 5171
        static let editBtnTag: NSInteger    = 5172
        static let deletedBtnTag: NSInteger = 5173
    }
    
    static let ZXAddressCellID: String = "ZXAddressCell"
    weak var delegate:ZXAddressCellDelegate?
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var telLB: UILabel!
    @IBOutlet weak var addressLB: UILabel!
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var contentMaskView: ZXUIView!
    var addModel: ZXAddressModel = ZXAddressModel()
    
    @IBOutlet weak var sepatorLine: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor.zx_subTintColor
        self.setStyleUI()
    }
    
    func setStyleUI() -> Void {
        self.nameLB.font = UIFont.zx_bodyFont
        self.nameLB.textColor = UIColor.zx_textColorTitle
        
        self.telLB.textColor = UIColor.zx_textColorTitle
        self.telLB.font = UIFont.zx_bodyFont
        
        self.addressLB.adjustsFontSizeToFitWidth = true
        self.addressLB.textColor = UIColor.zx_textColorTitle
        self.addressLB.font = UIFont.zx_titleFont
        
        self.editBtn.setTitleColor(UIColor.zx_textColorMark, for: UIControlState.normal)
        self.editBtn.titleLabel?.font = UIFont.zx_bodyFont
        
        self.deleteBtn.setTitleColor(UIColor.zx_textColorMark, for: UIControlState.normal)
        self.deleteBtn.titleLabel?.font = UIFont.zx_bodyFont
        
        self.statusBtn.setTitleColor(UIColor.zx_textColorTitle, for: UIControlState.selected)
        self.statusBtn.titleLabel?.font = UIFont.zx_bodyFont
        
        self.sepatorLine.backgroundColor = UIColor.zx_borderColor
    }
    
    
    func reloadData(_ model:ZXAddressModel) -> Void {
        
        self.addModel = model
        
        if model.consignee.isKind(of:NSNull.classForCoder()) == false {
            self.nameLB.text = model.consignee
        }
        if model.tel.isKind(of:NSNull.classForCoder()) == false {
            self.telLB.text = model.tel
        }
        self.addressLB.text = NSString.init(format: "%@%@", model.cityAddress,model.detailAddress) as String
        
        if model.isDefault == 1 {
            self.statusBtn.isSelected = true
            self.statusBtn.setTitleColor(UIColor.zx_tintColor, for: .normal)
        }else if model.isDefault == 0 {
            self.statusBtn.isSelected = false
            self.statusBtn.setTitleColor(UIColor.zx_textColorTitle, for: .normal)
        }
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        
        if delegate != nil {
            delegate?.didSelectedAddressAction(sender,self.addModel)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
