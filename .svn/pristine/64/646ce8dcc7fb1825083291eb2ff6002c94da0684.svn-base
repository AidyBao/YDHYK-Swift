//
//  ZXUCCashCouponCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/8.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXUCCashCouponCell: UITableViewCell {

    @IBOutlet weak var contentBackView: UIView!
    @IBOutlet weak var imgIcon: ZXUIImageView!
    @IBOutlet weak var lbStoreName: UILabel!
    @IBOutlet weak var lbCouponMoney: UILabel!
    @IBOutlet weak var lbExpireDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        self.contentView.backgroundColor = .clear
        self.contentBackView.backgroundColor = .white
        self.contentBackView.layer.shadowRadius = 1
        self.contentBackView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.contentBackView.layer.shadowOpacity = 0.25
        self.contentBackView.layer.cornerRadius = 5
        
        imgIcon.backgroundColor = UIColor.zx_backgroundColor
        imgIcon.layer.borderColor = UIColor.zx_borderColor.cgColor
        imgIcon.layer.borderWidth = 1
        
        lbStoreName.font = UIFont.zx_titleFont(13)
        lbStoreName.textColor = UIColor.zx_textColorMark//过期  颜色
        lbStoreName.highlightedTextColor = UIColor.zx_textColorTitle//未过期 颜色
        
        lbCouponMoney.font = UIFont.zx_titleFont(22)
        lbCouponMoney.textColor = UIColor.zx_textColorMark
        lbCouponMoney.highlightedTextColor = UIColor.zx_textColorTitle
        
        lbExpireDate.font = UIFont.zx_titleFont(13)
        lbExpireDate.textColor = UIColor.zx_textColorMark
        
    }

    func reloadData(model: ZXUCCashCouponModel?, isValid: Bool) {
        imgIcon.image = nil
        lbStoreName.text = nil
        lbCouponMoney.text = nil
        lbExpireDate.text = nil
        if let model = model {
            imgIcon.kf.setImage(with: URL.init(string: model.headPortraitStr))
            if isValid {//未失效
                lbStoreName.isHighlighted = true
                lbCouponMoney.isHighlighted = true
                
                lbStoreName.text = model.couponGroupName
                lbCouponMoney.text = model.zx_couponDescription
                lbExpireDate.text = model.zx_expiredDesc
            } else {//已失效
                lbStoreName.isHighlighted = false
                lbCouponMoney.isHighlighted = false
                
                lbStoreName.text = model.couponGroupName
                lbCouponMoney.text = model.zx_couponDescription
                if model.isUse == 1 {//已使用
                    lbExpireDate.text = "已使用"
                } else {
                    lbExpireDate.text = "已过期"
                }
            }
        }
    }
    
}
