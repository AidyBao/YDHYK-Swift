//
//  ZXItemInputCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/22.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

protocol ZXItemInputCellDelegate: class {
    func zxItemInputCellDeleteAction(cell: ZXItemInputCell)
    //func zxItemInputCell(cell: ZXItemInputCell,refrenceValue value: String)
    //func zxItemInputCell(cell: ZXItemInputCell,resultValue value: String)
}

class ZXItemInputCell: UITableViewCell {

    weak var delegate: ZXItemInputCellDelegate?
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbRefrenceValueTitle: UILabel!
    @IBOutlet weak var lbResultValueTitle: UILabel!
    @IBOutlet weak var lbRefrenceValue: UIButton!
    @IBOutlet weak var lbResultValue: UIButton!
    
    @IBOutlet weak var btnRefrenceValueInput: UIButton!
    @IBOutlet weak var btnResultValueInput: UIButton!
    var itemModel: ZXCheckItemDetailModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbRefrenceValueTitle.font = UIFont.zx_bodyFont(15)
        self.lbRefrenceValueTitle.textColor = UIColor.zx_textColorTitle
        self.lbResultValueTitle.font = UIFont.zx_bodyFont(15)
        self.lbResultValueTitle.textColor = UIColor.zx_textColorTitle
        
        self.btnRefrenceValueInput.titleLabel?.font = UIFont.zx_bodyFont(15)
        self.btnRefrenceValueInput.setTitleColor(UIColor.zx_textColorMark, for: .normal)
        self.btnRefrenceValueInput.setTitleColor(UIColor.zx_textColorTitle, for: .highlighted)
        self.btnRefrenceValueInput.setTitleColor(UIColor.zx_textColorTitle, for: .selected)
        
        self.btnResultValueInput.titleLabel?.font = UIFont.zx_bodyFont(15)
        self.btnResultValueInput.setTitleColor(UIColor.zx_textColorMark, for: .normal)
        self.btnResultValueInput.setTitleColor(UIColor.zx_textColorTitle, for: .highlighted)
        self.btnResultValueInput.setTitleColor(UIColor.zx_textColorTitle, for: .selected)
        
        self.btnRefrenceValueInput.titleLabel?.adjustsFontSizeToFitWidth = true
        self.btnResultValueInput.titleLabel?.adjustsFontSizeToFitWidth = true
    }

    func reloadData(model: ZXCheckItemDetailModel?) {
        itemModel = model
        self.lbName.text = ""
        self.btnRefrenceValueInput.setTitle("请录入", for: .normal)
        self.btnResultValueInput.setTitle("请录入", for: .normal)
        self.btnRefrenceValueInput.isSelected = false
        self.btnResultValueInput.isSelected = false
        if let model = model {
            self.lbName.text = model.itemName
            switch model.zx_referenceValueTypeKey {
            case .plus_minusType://+/- 类型
                if !model.strReferenceAddSub.isEmpty {//参考值 已填写
                    btnRefrenceValueInput.setTitle(model.strReferenceAddSub, for: .normal)
                    btnRefrenceValueInput.isSelected = true
                }
                if !model.strResultAddSub.isEmpty {//结果值 已填写
                    btnResultValueInput.setTitle(model.strResultAddSub, for: .normal)
                    btnResultValueInput.isSelected = true
                }
            case .yyTextType://阴阳类型
                if !model.strReferenceNegativePositive.isEmpty {//参考值 已填写
                    btnRefrenceValueInput.setTitle(model.strReferenceNegativePositive, for: .normal)
                    btnRefrenceValueInput.isSelected = true
                }
                if !model.strResultNegativePositive.isEmpty {//结果值 已填写
                    btnResultValueInput.setTitle(model.strResultNegativePositive, for: .normal)
                    btnResultValueInput.isSelected = true
                }
            case .valueType://值类型
                if !model.referenceMinValue.isEmpty {//参考值 已填写
                    btnRefrenceValueInput.setTitle(model.sectionRefrenceValueDesc, for: .normal)
                    btnRefrenceValueInput.isSelected = true
                }
                if !model.resultValue.isEmpty {//结果值 已填写
                    btnResultValueInput.setTitle(model.resultValue, for: .normal)
                    btnResultValueInput.isSelected = true
                }
            default:
                break
            }
        }
    }
    
    @IBAction func delegateAcion(_ sender: Any) {
        delegate?.zxItemInputCellDeleteAction(cell: self)
    }
    
    @IBAction func refrenceValueAction(_ sender: Any) {
        if let delegate = delegate as? UIViewController {
            //不限制类型选择
            ZXCheckItemInputViewController.showRefrenceDataInput(uponeon: delegate, typeIndex: 0, completion: { (valuetype, minRef, maxRef, refValue, index) in
                if let value = refValue {
                    self.btnRefrenceValueInput.setTitle(value, for: .normal)
                    self.btnRefrenceValueInput.isSelected = true
                }
                self.itemModel?.referenceValueTypeKey = valuetype.rawValue
                switch valuetype {
                    case .valueType:
                        self.itemModel?.referenceMinValue = minRef ?? ""
                        self.itemModel?.referenceMaxValue = maxRef ?? ""
                    case .plus_minusType:
                        self.itemModel?.referenceAddSub = "\(index)"//保存的值为 0 1
                    case .yyTextType:
                        self.itemModel?.referenceNegativePositive = "\(index)"//保存的值为 0 1
                    default:
                        break
                }
                //类型不一致,清空结果值
                if self.itemModel?.referenceValueTypeKey != self.itemModel?.resultValueTypeKey {
                    self.btnResultValueInput.setTitle("请录入", for: .normal)
                    self.btnResultValueInput.isSelected = false
                    switch valuetype {
                        case .valueType:
                            self.itemModel?.resultValue = ""
                        case .plus_minusType:
                            self.itemModel?.resultAddSub = ""
                        case .yyTextType:
                            self.itemModel?.resultNegativePositive = ""
                        default:
                            break
                    }
                }
            })
        }
    }
    
    @IBAction func resultValueAction(_ sender: Any) {
        if let delegate = delegate as? UIViewController,let model = self.itemModel {
            switch model.zx_referenceValueTypeKey {
            case .plus_minusType:// + 1 - 0
                if !model.referenceAddSub.isEmpty {
                    ZXCheckItemInputViewController.showResultDataInput(unponon: delegate, typeIndex: 2, completion: { (valuetype, value, index) in
                        if let value = value {
                            self.btnResultValueInput.setTitle(value, for: .normal)
                            self.btnResultValueInput.isSelected = true
                        }
                        self.itemModel?.resultValueTypeKey = valuetype.rawValue
                        self.itemModel?.resultAddSub = "\(index)"
                    })
                } else {
                    ZXHUD.showFailure(in: delegate.view, text: "请先录入参考值", delay: ZX.HUDDelay)
                }
            case .yyTextType:// 阴 0 阳 1
                if !model.referenceNegativePositive.isEmpty {
                    ZXCheckItemInputViewController.showResultDataInput(unponon: delegate, typeIndex: 1, completion: { (valuetype, value, index) in
                        if let value = value {
                            self.btnResultValueInput.setTitle(value, for: .normal)
                            self.btnResultValueInput.isSelected = true
                        }
                        self.itemModel?.resultValueTypeKey = valuetype.rawValue
                        self.itemModel?.resultNegativePositive = "\(index)"
                    })
                } else {
                    ZXHUD.showFailure(in: delegate.view, text: "请先录入参考值", delay: ZX.HUDDelay)
                }
            case .valueType:// 值
                if !model.referenceMinValue.isEmpty {
                    ZXCheckItemInputViewController.showResultDataInput(unponon: delegate, typeIndex: 0, completion: { (valuetype, value, index) in
                        if let value = value {
                            self.btnResultValueInput.setTitle(value, for: .normal)
                            self.btnResultValueInput.isSelected = true
                            self.itemModel?.resultValueTypeKey = valuetype.rawValue
                            self.itemModel?.resultValue = value
                        }
                    })
                } else {
                    ZXHUD.showFailure(in: delegate.view, text: "请先录入参考值", delay: ZX.HUDDelay)
                }

            default:
                break
            }
        }
    }
    
    
}
