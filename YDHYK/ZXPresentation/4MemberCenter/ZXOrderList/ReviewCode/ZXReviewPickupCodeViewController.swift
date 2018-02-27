//
//  ZXReviewPickupCodeViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/7.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 查看提货码
class ZXReviewPickupCodeViewController: ZXUIViewController {
    var orderId: String?
    
    let checkCodeTintColor = UIColor.zx_colorRGB(53, 167, 144, 1.0)
    
    @IBOutlet weak var topOffset: NSLayoutConstraint!
    @IBOutlet weak var vCodeContent: UIView!
    @IBOutlet weak var imgQRCode: UIImageView!
    
    @IBOutlet weak var vCheckCodeContent: UIView!
    @IBOutlet weak var lbCodeTitle: UILabel!
    @IBOutlet weak var lbCheckCode: UILabel!
    
    @IBOutlet weak var vCashCodeContent: UIView!
    @IBOutlet weak var lbCashCodeTitle: UILabel!
    @IBOutlet weak var lbCashCode: UILabel!
    
    @IBOutlet weak var lbBottomInfo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "提货码"
        // Do any additional setup after loading the view.
        self.view.backgroundColor = checkCodeTintColor
        lbCodeTitle.font = UIFont.zx_titleFont(16)
        lbCodeTitle.textColor = UIColor.zx_textColorTitle
        lbCheckCode.font = UIFont.zx_titleFont(26)
        lbCheckCode.textColor = checkCodeTintColor
        
        lbCashCodeTitle.font = UIFont.zx_titleFont(16)
        lbCashCodeTitle.textColor = UIColor.zx_textColorTitle
        lbCashCode.font = UIFont.zx_titleFont(26)
        lbCashCode.textColor = checkCodeTintColor
        
        lbBottomInfo.font = UIFont.zx_subTitleFont
        lbBottomInfo.textColor = UIColor.zx_colorRGB(176, 255, 241, 1.0)
        
        if UIDevice.zx_DeviceSizeType() == .s_4_0Inch {
            topOffset.constant = 20
        } else {
            topOffset.constant = 45
        }
        
        imgQRCode.backgroundColor = UIColor.zx_borderColor
        //暂时都没有现金券
        vCashCodeContent.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.zx_setNavBarBackgroundColor(checkCodeTintColor)
        if !onceLoad {
            self.loadPickUpCode()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.zx_setNavBarBackgroundColor(UIColor.zx_tintColor)
    }
    
    func loadPickUpCode() {
        if let orderId = orderId {
            ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
            ZXUCOrderViewModel.pickupCode(orderId: orderId, completion: { (success, code, image, pickupCode, errorMsg) in
                ZXHUD.hide(for: self.view, animated: true)
                if success {
                    self.imgQRCode.image = image
                    self.lbCheckCode.text = pickupCode
                } else {
                    if code != ZXAPI_LOGIN_INVALID {
                        ZXAlertUtils.showAlert(wihtTitle: "提示", message: "没有提货码信息", buttonText: "确定", action: {
                            self.navigationController?.popViewController(animated: true)
                        })
                    } else {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            })
        } else {
            ZXHUD.showFailure(in: self.view, text: "订单ID为空", delay: ZX.HUDDelay)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let maskPath1 = UIBezierPath.init(roundedRect: vCodeContent.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 5, height: 5))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = vCodeContent.bounds
        maskLayer1.path = maskPath1.cgPath
        vCodeContent.layer.mask = maskLayer1
        //暂时都没有现金券Code
        
        let maskPath2 = UIBezierPath.init(roundedRect: vCheckCodeContent.bounds, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 5, height: 5))
        let maskLayer2 = CAShapeLayer()
        maskLayer2.frame = vCheckCodeContent.bounds
        maskLayer2.path = maskPath2.cgPath
        vCheckCodeContent.layer.mask = maskLayer2
    }
    
}
