//
//  ZXFullCheckViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/27.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

typealias ZXListCheckEnd = (_ index: Int,_ value: String) -> Void

class ZXFullCheckViewController: ZXUIViewController, UITableViewDelegate, UITableViewDataSource,UIViewControllerTransitioningDelegate {
    var titleName: String?
    var callBack: ZXListCheckEnd?
    var itemList: Array<String> = []
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tblList: UITableView!
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    static func present(on vc: UIViewController,title: String,list: Array<String>,callBack: ZXListCheckEnd?) {
        let listVC = ZXFullCheckViewController()
        listVC.titleName = title
        listVC.itemList = list
        listVC.callBack = callBack
        vc.present(listVC, animated: true, completion: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.clear
        self.tblList.register(UINib.init(nibName: ZXCheckSelectCell.NibName, bundle: nil), forCellReuseIdentifier: ZXCheckSelectCell.reuseIdentifier)
        self.lbTitle.font = UIFont.zx_titleFont(15)
        self.lbTitle.textColor = UIColor.zx_textColorTitle
        self.lbTitle.text = titleName ?? "请选择"
        if itemList.count > 2 {
            viewHeight.constant = CGFloat(itemList.count * 50 + 40)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        callBack?(indexPath.row,itemList[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZXCheckSelectCell.reuseIdentifier, for: indexPath) as! ZXCheckSelectCell
        cell.lbName.text = itemList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self.contentView)
            if !self.contentView.bounds.contains(point) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ZXDimmingPresentationController.init(presentedViewController: presented, presenting: presenting)
    }
}
