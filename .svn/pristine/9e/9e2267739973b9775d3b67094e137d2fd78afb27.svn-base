//
//  ZXFlashScreenViewController.swift
//  YDHYK
//
//  Created by 120v on 2017/11/2.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXFlashScreenViewController: UIViewController {
    fileprivate var timer:Timer?
    @IBOutlet weak var countdownBtn: UIButton!
    @IBOutlet weak var flashImgView: UIImageView!
    fileprivate var flashCount: Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadFlashScreen()
        
        ZXLoginManager.requestForFlashScreen()
    }
    
    func loadFlashScreen() {
        let flashImageURL = ZXUser.user.getFlashImageURL()
        let flashImage = ZXUser.user.getFlashImage()
        if flashImage != nil {
            self.flashImgView.image = flashImage
            self.start()
        }else if flashImageURL.isEmpty == false {
            self.flashImgView.kf.setImage(with: URL.init(string: flashImageURL), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            self.start()
        }else{
            self.flashImgView.image = UIImage.init(named: "")
            self.countdownBtn.isHidden = true
            self.flashCount = 0
            self.backToLogin()
        }
    }
    
    func start() {
        self.reset()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown(_:)), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .commonModes)
        timer?.fire()
    }
    
    func reset() {
        if timer != nil {
            timer?.invalidate()
            self.timer = nil
        }
        self.countdownBtn.setTitle("5s 点击跳过", for:.normal)
    }
    
    @objc func countdown(_ sender: UIButton) {
        if flashCount <= 0 {
            flashCount = 0
            self.backToLogin()
        }else{
            self.countdownBtn.setTitle("\(self.flashCount) 点击跳过", for: .normal)
        }
        flashCount -= 1
    }
    
    @IBAction func countdownBtnAction(_ sender: UIButton) {
        self.backToLogin()
    }
    
    func backToLogin() {
        self.timer?.invalidate()
        timer = nil
        
        ZXRouter.changeRootViewController(ZXRootController.zx_tabbarVC())
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
