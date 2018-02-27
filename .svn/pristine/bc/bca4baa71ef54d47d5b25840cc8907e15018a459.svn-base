//
//  ZXMyQRCodeViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/3.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 会员二维码
class ZXMyQRCodeViewController: ZXUIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgSex: UIImageView!
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var lbTips: UILabel!
    
    @IBOutlet weak var lbTitle: UILabel!
    let gradientColor: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.zx_colorRGB(95, 168, 250, 1).cgColor,UIColor.zx_colorRGB(59, 135, 239, 1).cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        layer.contentsScale = UIScreen.main.scale
        layer.frame = UIScreen.main.bounds
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.contentView.backgroundColor = UIColor.zx_tintColor
        self.contentView.layer.insertSublayer(self.gradientColor, at: 0)

        imgIcon.layer.masksToBounds = true
        imgIcon.backgroundColor = UIColor.zx_borderColor
        
        lbName.textColor = UIColor.zx_textColorTitle
        lbName.font = UIFont.zx_titleFont
        lbTips.textColor = UIColor.zx_colorWithHexString("#ddecff")
        lbTips.font = UIFont.zx_subTitleFont
        
        imgQRCode.backgroundColor = UIColor.zx_borderColor
        
        self.lbTitle.font = ZXNavBarConfig.navTilteFont(ZXNavBarConfig.titleFontSize)
        self.lbTitle.textColor = .white
        self.lbTitle.text = "验证会员"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imgIcon.layer.cornerRadius = self.imgIcon.frame.size.width / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.reloadUI()
    }
    
    func reloadUI() {
        let user = ZXUser.user
        var defaultIcon = #imageLiteral(resourceName: "touxiang-man")
        if user.sex == 0 {
            imgSex.isHighlighted = false
            defaultIcon = #imageLiteral(resourceName: "touxiang-woman")
        } else {
            imgSex.isHighlighted = true
        }
        lbName.text = user.name
        imgIcon.kf.setImage(with: URL.init(string: user.headPortraitFilesStr), placeholder: defaultIcon)
        imgQRCode.kf.setImage(with: URL.init(string: user.qrStr))
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
