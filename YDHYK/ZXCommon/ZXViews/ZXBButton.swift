//
//  ZXBButton.swift
//  YDHYK
//
//  Created by 120v on 2017/11/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

@IBDesignable
class ZXBButton: ZXUIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleColor(UIColor.white, for: .normal)
        self.setImage(#imageLiteral(resourceName: "icon-more"), for: .normal)
        self.setImage(#imageLiteral(resourceName: "icon-shou"), for: .selected)
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel?.frame.origin.x = self.frame.size.width*0.5 - (self.titleLabel?.frame.size.width)!*0.5
        self.imageView?.frame.origin.x = self.titleLabel!.frame.maxX + 2
    }
}
