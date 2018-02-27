//
//  ZXOneCardNoticeView.swift
//  YDHYK
//
//  Created by 120v on 2017/11/8.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXOneCardNoticeView: UIView {
    
    class func loadNib() -> ZXOneCardNoticeView {
        return Bundle.main.loadNibNamed(String.init(describing: ZXOneCardNoticeView.self), owner: self, options: nil)?.first as! ZXOneCardNoticeView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        self.frame = UIScreen.main.bounds
    }
    
    override func layoutSubviews() {
        self.layoutIfNeeded()
    }

    @IBAction func dimissBunAction(_ sender: UIButton) {
        self.saveFirstClick(true)
        self.removeFromSuperview()
    }
    
    func saveFirstClick(_ isFirst: Bool) {
        UserDefaults.standard.set(isFirst, forKey: "oneCardIsClick")
        UserDefaults.standard.synchronize()
    }

}
