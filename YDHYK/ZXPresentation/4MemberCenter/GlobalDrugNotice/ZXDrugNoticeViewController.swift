//
//  ZXDrugNoticeViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/15.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXDrugNoticeViewController: ZXUIViewController {
    var remindTime = ""
    var list: Array<ZXTakeMedicineModel> = []
    
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbTipsInfo: UILabel!
    @IBOutlet weak var tblRemindList: UITableView!
    @IBOutlet weak var btnEatNow1: UIButton!
    @IBOutlet weak var btnRemindLater: UIButton!
    @IBOutlet weak var btnEatNow2: UIButton!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not init")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.clear
        
        self.lbTime.font = UIFont.zx_titleFont(40)
        self.lbTime.textColor = UIColor.zx_tintColor
        
        self.lbTipsInfo.font = UIFont.zx_titleFont(13)
        self.lbTipsInfo.textColor = UIColor.zx_tintColor
        
        btnEatNow1.layer.masksToBounds = true
        btnEatNow1.layer.cornerRadius = 5
        btnEatNow1.backgroundColor = UIColor.white
        btnEatNow1.setTitleColor(UIColor.zx_tintColor, for: .normal)
        btnEatNow1.titleLabel?.font = UIFont.zx_titleFont(15)
        
        btnEatNow2.layer.masksToBounds = true
        btnEatNow2.layer.cornerRadius = 5
        btnEatNow2.backgroundColor = UIColor.white
        btnEatNow2.setTitleColor(UIColor.zx_tintColor, for: .normal)
        btnEatNow2.titleLabel?.font = UIFont.zx_titleFont(15)
        
        btnRemindLater.layer.masksToBounds = true
        btnRemindLater.layer.cornerRadius = 5
        btnRemindLater.backgroundColor = UIColor.zx_colorRGB(103, 103, 103, 1)
        btnRemindLater.setTitleColor(UIColor.white, for: .normal)
        btnRemindLater.titleLabel?.font = UIFont.zx_titleFont(15)
        
        self.tblRemindList.backgroundColor = .clear
        self.tblRemindList.separatorStyle = .none
        
        self.tblRemindList.register(UINib.init(nibName: ZXDrugRemindCell.NibName, bundle: nil), forCellReuseIdentifier: ZXDrugRemindCell.reuseIdentifier)
        
        btnEatNow1.isHidden = true
        btnRemindLater.isHidden = true
        configButton()
        
        lbTime.text = self.remindTime
    }
    
    fileprivate func configButton() {
        if ZXUser.user.isRepeatedReminders == 0 {//0 开 1 关 重复提醒
            btnEatNow2.isHidden = true
            btnEatNow1.isHidden = false
            btnRemindLater.isHidden = false
        } else {
            btnEatNow2.isHidden = false
            btnEatNow1.isHidden = true
            btnRemindLater.isHidden = true
        }
    }
    
    @IBAction func remindLaterAction(_ sender: Any) {
        if self.list.count > 0 {
            var arrIds: Array<String> = []
            for d in self.list {
                arrIds.append(d.detailId)
            }
            ZXDrugNoticeViewModel.remindLater(ids: arrIds.joined(separator: ","))
        }
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func eatNowAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ZXDrugNoticeViewController:UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ZXDimmingPresentationController.init(presentedViewController: presented, presenting: presenting)
    }
}

extension ZXDrugNoticeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 38
    }
}

extension ZXDrugNoticeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZXDrugRemindCell.reuseIdentifier, for: indexPath) as! ZXDrugRemindCell
        cell.reloadData(model: self.list[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
}
