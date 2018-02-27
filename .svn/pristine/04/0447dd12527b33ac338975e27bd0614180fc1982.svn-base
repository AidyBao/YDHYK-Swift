//
//  ZXJoinSuccessViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/3.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 加入会员-成功界面
class ZXJoinSuccessViewController: ZXUIViewController,UIGestureRecognizerDelegate {

    var storeInfo: ZXStoreShortModel?
    @IBOutlet weak var imgSuccess: UIImageView!//图片填充不完，处理背景
    @IBOutlet weak var imgStoreIcon: ZXUIImageView!
    @IBOutlet weak var lbStoreName: UILabel!
    
    @IBOutlet weak var btnAccessStore: ZXUIButton!
    @IBOutlet weak var lbBottomTips: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imgSuccess.backgroundColor = UIColor.zx_tintColor
        lbStoreName.textColor = UIColor.zx_textColorTitle
        lbStoreName.text = ""
        lbStoreName.font = UIFont.zx_titleFont
        
        lbBottomTips.titleLabel?.font = UIFont.zx_titleFont(13)
        lbBottomTips.setTitleColor(UIColor.zx_textColorMark, for: .normal)
        
        btnAccessStore.backgroundColor = UIColor.zx_tintColor
        
        let strInfo = "您可以在首页-卡•购药查看该药店会员卡"
        let attStr = NSMutableAttributedString.zx_lineFormat(strInfo, type: .underLine, at: NSMakeRange(4, 7))
        lbBottomTips.setAttributedTitle(attStr, for: .normal)
        if let storeInfo = self.storeInfo {
            lbStoreName.text = storeInfo.name
            imgStoreIcon.kf.setImage(with: URL.init(string: storeInfo.headPortraitStr))
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let vc = self.navigationController?.viewControllers.last {
            if !(vc is ZXQRCodeScanViewController) {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }
        }
    }
    
    
    @IBAction func accessStoreAction(_ sender: Any) {
        if let store = storeInfo {
            let store = ZXStoreRootViewController.configVC(storeId: store.storeId, memberId: ZXUser.user.memberId, token: ZXUser.user.userToken)
            self.navigationController?.pushViewController(store, animated: true)
        }
    }
    
    @IBAction func jumpToMemberCards(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popToRootViewController(animated: false)
            ZXRouter.tabbarSelect(at: 2)
        } else {
            self.dismiss(animated: false, completion: {
                ZXRouter.tabbarSelect(at: 2)
            })
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
