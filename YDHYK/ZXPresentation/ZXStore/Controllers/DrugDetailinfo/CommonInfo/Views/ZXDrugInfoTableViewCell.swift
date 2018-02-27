//
//  ZXDrugInfoTableViewCell.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/5/22.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 药品详情基本信息 - 名字，规格，价格
class ZXDrugInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var lbDrugName_Spec: UILabel!
    @IBOutlet weak var lbDrugEffect: UILabel!
    
    @IBOutlet weak var lbPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbDrugName_Spec.font = UIFont.zx_titleFont(UIFont.zx_subTitleFontSize)
        self.lbDrugName_Spec.textColor = UIColor.zx_textColorTitle
        
        self.lbDrugEffect.font = UIFont.zx_titleFont(UIFont.zx_bodyFontSize - 1)
        self.lbDrugEffect.textColor = UIColor.zx_textColorMark
        
        
        self.lbPrice.font = UIFont.zx_titleFont(UIFont.zx_bodyFontSize)
        self.lbPrice.textColor = UIColor.zx_textColorTitle
        
        self.lbDrugName_Spec.text = ""
        self.lbDrugEffect.text = ""
        self.lbPrice.text = ""
    }
    
    func reloadData(_ model:ZXDrugDetailModel?,selectedSpec:ZXDrugSpecModel?) {
        if let model = model {
            var isPrescription = false
            if model.isPrescription == 1{
                isPrescription = true
            }
            var spec = model.packingSpec
            var price = "\(model.zx_truePrice)"
            if let selected = selectedSpec {
                spec = selected.name
                price = selected.price
            }
            self.setDrugName(model.drugName, isPrescription: isPrescription, spec: spec)
            var effectInfo = model.functionIndications
            effectInfo = effectInfo.replacingOccurrences(of: "</*[^<>]*>*", with: "", options: .regularExpression, range: effectInfo.startIndex..<effectInfo.endIndex)
            self.lbDrugEffect.text = effectInfo
            let pText = "会员价 " + price.zx_priceString()
            let attrPtext = NSAttributedString.zx_colorFormat(pText, color: UIColor.zx_customBColor, at: NSMakeRange(4, pText.count - 4))
            attrPtext.zx_appendFont(font: UIFont.zx_bodyFont(UIFont.zx_bodyFontSize), at: NSMakeRange(0, 3))
            attrPtext.zx_appendFont(font: UIFont.boldSystemFont(ofSize: UIFont.zx_subTitleFontSize), at: NSMakeRange(4, pText.count - 4))
            self.lbPrice.attributedText = attrPtext
        } else {
            self.lbDrugName_Spec.text = ""
            self.lbDrugEffect.text = ""
            self.lbPrice.text = ""
        }
    }
    
    fileprivate func setDrugName(_ name:String,isPrescription:Bool,spec:String) {
        var drugName = " \(name)"
        if spec.count > 0 {
            drugName += " \(spec)"
        }
        let attachment = NSTextAttachment(data: nil, ofType: nil)
        var image = #imageLiteral(resourceName: "otc") //非处方药
        if isPrescription {
            image = #imageLiteral(resourceName: "rx")
        }
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: -3, width: 31, height: 15)
        let imgAttr = NSAttributedString(attachment: attachment)
        let textAttr =  NSAttributedString.zx_fontFormat(drugName, font: UIFont.zx_bodyFont(16), at: NSMakeRange(0, drugName.count))
        textAttr.insert(imgAttr, at: 0)
        self.lbDrugName_Spec.textColor = UIColor.zx_textColorTitle
        self.lbDrugName_Spec.attributedText = textAttr
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}