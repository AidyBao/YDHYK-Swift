//
//  ZXNormalAnnotationView.swift
//  YDHYK
//
//  Created by 120v on 2017/11/16.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXNormalAnnotationView: BMKAnnotationView {
    
    static let ZXNormalAnnotationViewID: String = "ZXNormalAnnotationView"
    
    var storeId: Int = 0
    var normalImag: UIImage = UIImage.init()
    var isChineseMedicine: Int = -1

    override init!(annotation: BMKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.bounds = CGRect.init(x: 0.0, y: 0.0, width: 50.25, height: 60.25)
        self.normalImgView.frame = self.bounds
        self.backgroundColor = UIColor.clear
        self.normalImgView.contentMode = .center
        self.addSubview(self.normalImgView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setNormalImage(_ normalImg: UIImage) {
        self.normalImgView.image = normalImg
        self.normalImgView.animationDuration = 3.0
    }
    
    lazy var normalImgView: UIImageView = {
        let normal: UIImageView = UIImageView.init()
        return normal
    }()
}
