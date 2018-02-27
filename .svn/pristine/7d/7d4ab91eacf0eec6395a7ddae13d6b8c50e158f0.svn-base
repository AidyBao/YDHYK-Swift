//
//  ZXTitleButton.swift
//  YDHYK
//
//  Created by 120v on 2017/11/7.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

@IBDesignable
class ZXTitleButton: ZXUIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.setImage(#imageLiteral(resourceName: "icon-go"), for: UIControlState.normal)
        self.setImage(#imageLiteral(resourceName: "icon-go"), for: UIControlState.selected)
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    /**
     这个方法里调整布局
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel?.frame.origin.x = self.frame.size.width*0.5 - (self.titleLabel?.frame.size.width)!*0.5
        self.imageView?.frame.origin.x = self.titleLabel!.frame.maxX + 2
    }

}
