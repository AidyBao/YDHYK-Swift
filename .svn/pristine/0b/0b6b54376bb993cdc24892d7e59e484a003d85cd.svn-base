//
//  ZXAgeSexInputCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/22.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
let ZXItemInputAgeTextFiledTag = 809003

protocol ZXAgeSexInputCellDelegate: class {
    func zxAgeSexIntpuCell(cell: ZXAgeSexInputCell,sexSelected index: Int,text: String?)
    func zxAgeSexIntpuCell(cell: ZXAgeSexInputCell,agevalueChanged age: String?)
}

class ZXAgeSexInputCell: UITableViewCell,UITextFieldDelegate {
    
    weak var delegate: ZXAgeSexInputCellDelegate?
    
    @IBOutlet weak var lbSex: UILabel!
    @IBOutlet weak var lbAge: UILabel!
    
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var btnSex: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        
        self.lbSex.font = UIFont.zx_bodyFont(15)
        self.lbSex.textColor = UIColor.zx_textColorTitle
        self.lbAge.font = UIFont.zx_bodyFont(15)
        self.lbAge.textColor = UIColor.zx_textColorTitle
        
        self.btnSex.titleLabel?.font = UIFont.zx_bodyFont(15)
        self.btnSex.setTitleColor(UIColor.zx_textColorMark, for: .normal)
        self.btnSex.setTitleColor(UIColor.zx_textColorTitle, for: .highlighted)
        self.btnSex.setTitleColor(UIColor.zx_textColorTitle, for: .selected)

        self.txtAge.font = UIFont.zx_bodyFont(15)
        self.txtAge.textColor = UIColor.zx_textColorTitle
        self.txtAge.delegate = self
        self.txtAge.tag = ZXItemInputAgeTextFiledTag
    }

    func reloadData(sex: String?, age: String?) {
        if let sex = sex {
            if sex == "1" || sex == "男" {
                btnSex.setTitle("男", for: .normal)
            } else {
                btnSex.setTitle("女", for: .normal)
            }
            btnSex.isSelected = true
        } else {
            btnSex.setTitle("请选择", for: .normal)
            btnSex.isSelected = false
        }
        txtAge.text = age
    }
    
    @IBAction func sexAction(_ sender: Any) {
        if let delegate = self.delegate as? UIViewController {
            ZXFullCheckViewController.present(on: delegate, title: "请选择性别", list: ["女", "男"], callBack: { (index, strSex) in
                self.delegate?.zxAgeSexIntpuCell(cell: self, sexSelected: index, text: strSex)
                self.btnSex.setTitle(strSex, for: .normal)
                self.btnSex.isSelected = true
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.txtAge.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.zxAgeSexIntpuCell(cell: self, agevalueChanged: textField.text)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0,!string.isEmpty,string.substring(to: 1) == "0" {
            return false
        }
        if range.location > 2 {
            return false
        }
        return true
    }
}
