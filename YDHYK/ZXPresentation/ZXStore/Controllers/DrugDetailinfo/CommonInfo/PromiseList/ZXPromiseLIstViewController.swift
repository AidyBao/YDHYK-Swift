//
//  ZXPromiseLIstViewController.swift
//  YDHYK
//
//  Created by screson on 2017/10/19.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 服务承诺
class ZXPromiseLIstViewController: ZXSTUIViewController,UITableViewDataSource,UITableViewDelegate {
    
    override var preferredCartButtonHidden: Bool { return true }
    override var preferredStatusBarStyle: UIStatusBarStyle { return .default }
    
    @IBOutlet weak var tblList: UITableView!
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ZXStoreRootViewController.cartButton.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .clear
        self.tblList.register(UINib.init(nibName: ZXPromiseCell.NibName, bundle: nil), forCellReuseIdentifier: ZXPromiseCell.reuseIdentifier)
        self.tblList.rowHeight = UITableViewAutomaticDimension
        self.tblList.estimatedRowHeight = 60
    }

    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point:CGPoint = (touches.first?.location(in: self.view))!
        if point.y < ZXBOUNDS_HEIGHT / 3 {
            self.dismiss(animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZXPromiseCell.reuseIdentifier, for: indexPath) as! ZXPromiseCell
        if let model = ZXStoreParams.storeInfo, model.zx_promiseList.count > 0 {
            cell.reloadData(model: ZXStoreParams.storeInfo?.zx_promiseList[indexPath.row])
            if indexPath.row == (model.zx_promiseList.count - 1) {
                cell.sLine.isHidden = true
            } else {
                cell.sLine.isHidden = false
            }
        } else {
            cell.reloadData(model: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let storeInfo = ZXStoreParams.storeInfo {
            return storeInfo.zx_promiseList.count
        }
        return 0
    }
    
    deinit {
        NotificationCenter.default.post(name: "ZXStatusBarUpdate".zx_noticeName(), object: nil)
    }
}

extension ZXPromiseLIstViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ZXDimmingPresentationController.init(presentedViewController: presented, presenting: presenting)
    }
}
