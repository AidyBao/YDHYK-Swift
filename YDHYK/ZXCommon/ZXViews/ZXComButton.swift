//
//  ZXComButton.swift
//  YDHYK
//
//  Created by 120v on 2017/11/29.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXComButton: ZXUIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImage(#imageLiteral(resourceName: "icon-go"), for: UIControlState.normal)
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
