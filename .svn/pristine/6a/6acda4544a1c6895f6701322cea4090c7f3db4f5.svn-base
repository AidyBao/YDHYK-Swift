//
//  ZXLoginButton.swift
//  YDHYK
//
//  Created by 120v on 2017/11/3.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXLoginButton: ZXUIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configUI()
    }
    
    func configUI() {
        self.titleLabel?.font = UIFont.zx_titleFont(UIFont.zx_titleFontSize)
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.zx_tintColor, for: .selected)
        self.setTitleColor(UIColor.zx_tintColor, for: .highlighted)
        self.setTitleColor(UIColor.white, for: .disabled)
        if self.isEnabled {
            self.backgroundColor = UIColor.zx_tintColor
        }else{
            self.backgroundColor = UIColor.zx_subTintColor
        }
    }
}
