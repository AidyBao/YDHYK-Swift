//
//  ZXJoinLeadViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/3.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 加入会员-引导界面
class ZXJoinLeadViewController: ZXUIViewController {

    @IBOutlet weak var lbTitle1: UILabel!
    @IBOutlet weak var lbSubTitle1: UILabel!
    
    @IBOutlet weak var lbTitle2: UILabel!
    @IBOutlet weak var lbSubTitle2: UILabel!
    
    @IBOutlet weak var lbTitle3: UILabel!
    @IBOutlet weak var lbSubTitle3: UILabel!
    
    @IBOutlet weak var btnDone: ZXUIButton!
    
    static func hasShowOnce() -> Bool {
        if let sValue = UserDefaults.standard.value(forKey: "ZXShowOnce") as? String, sValue == "ZXShowOnce" {
            return true
        }
        return false
    }
    
    static func checkShow(completion: ZXClosure_Empty?) {
        if self.hasShowOnce() {
            completion?()
        } else {
            let leadVC = ZXJoinLeadViewController()
            leadVC.completion = completion
            ZXRootController.topVC().present(leadVC, animated: true, completion: nil)
        }
    }
    
    
    var completion: ZXClosure_Empty?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        lbTitle1.textColor = UIColor.zx_tintColor
        lbTitle1.font = UIFont.zx_titleFont(20)
        lbSubTitle1.textColor = UIColor.zx_textColorTitle
        lbSubTitle1.font = UIFont.zx_titleFont(UIFont.zx_bodyFontSize)
        
        lbTitle2.textColor = UIColor.zx_colorWithHexString("#49bfec")
        lbTitle2.font = UIFont.zx_titleFont(20)
        lbSubTitle2.textColor = UIColor.zx_textColorTitle
        lbSubTitle2.font = UIFont.zx_titleFont(UIFont.zx_bodyFontSize)
        
        lbTitle3.textColor = UIColor.zx_colorWithHexString("#61d5b6")
        lbTitle3.font = UIFont.zx_titleFont(20)
        lbSubTitle3.textColor = UIColor.zx_textColorTitle
        lbSubTitle3.font = UIFont.zx_titleFont(UIFont.zx_bodyFontSize)
        
        self.btnDone.backgroundColor = UIColor.zx_tintColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaults.standard.setValue("ZXShowOnce", forKey: "ZXShowOnce")
        UserDefaults.standard.synchronize()
    }

    @IBAction func doneAction(_ sender: Any) {
        self.dismiss(animated: true) {
            self.completion?()
        }
    }
}
