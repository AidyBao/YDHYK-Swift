//
//  ZXDrugRemarkViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/6.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXDrugRemarkViewController: ZXUIViewController {

    @IBOutlet weak var tblList: UITableView!
    var drugList: Array<ZXUCMarkedDrugModel> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "药品收藏"
        // Do any additional setup after loading the view.
        self.tblList.backgroundColor = UIColor.zx_subTintColor
        self.tblList.register(UINib.init(nibName: ZXUCMarkedDrugCell.NibName, bundle: nil), forCellReuseIdentifier: ZXUCMarkedDrugCell.reuseIdentifier)
        self.tblList.zx_addHeaderRefresh(showGif: true, target: self, action: #selector(zx_refresh))
        self.tblList.mj_header.beginRefreshing()
    }
    
    override func zx_refresh() {
        self.loadMarkedDrugList()
    }
    
    func loadMarkedDrugList() {
        ZXUCMarkedDrugViewModel.list { (success, code, list, errorMsg) in
            self.tblList.mj_header.endRefreshing()
            ZXEmptyView.hide(from: self.tblList)
            if success {
                if let list = list {
                    self.drugList = list
                } else {
                    self.drugList = []
                }
                if self.drugList.count == 0 {
                     ZXEmptyView.show(in: self.tblList, type: .noData, text: "暂无收藏记录")
                }
                self.tblList.reloadData()
            } else {
                if code != ZXAPI_LOGIN_INVALID {
                    ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                }
            }
        }
    }
}

extension ZXDrugRemarkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let drugDetailVC = ZXDrugDetailInfoViewController()
        let drug = self.drugList[indexPath.section]
        let shortModel = ZXDrugModel()
        shortModel.baseDrugId = drug.drugId
        shortModel.approvalNumber = drug.approvalNumber
        shortModel.drugstoreId = drug.drugstoreId
        drugDetailVC.goodsShortModel = shortModel
        self.navigationController?.pushViewController(drugDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ZXUCMarkedDrugCell.heigt
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        } else {
            let lastM = self.drugList[section - 1]
            let current = self.drugList[section]
            if current.drugstoreId == lastM.drugstoreId {
                return CGFloat.leastNormalMagnitude
            }
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = self.tableView(tableView, titleForHeaderInSection: section)
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: ZXBOUNDS_WIDTH, height: 20))
        label.backgroundColor = UIColor.zx_subTintColor
        label.textColor = UIColor.zx_textColorTitle
        label.font = UIFont.zx_titleFont(12)
        label.text = "  " + (title ?? "")
        label.clipsToBounds = true
        return label
    }
}

extension ZXDrugRemarkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.drugList[section].drugstoreName
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZXUCMarkedDrugCell.reuseIdentifier, for: indexPath) as! ZXUCMarkedDrugCell
        cell.reloadData(model: self.drugList[indexPath.section])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let drug = self.drugList[indexPath.section]
            ZXHUD.showLoading(in: self.view, text: "删除中...", delay: 0)
            ZXUCMarkedDrugViewModel.delete(with: drug.markId, completion: { (success, errorMsg) in
                ZXHUD.hide(for: self.view, animated: true)
                if success {
                    self.drugList.remove(at: indexPath.section)
                    self.tblList.deleteSections(IndexSet([indexPath.section]), with: .automatic)
                    if self.drugList.count == 0 {
                        self.loadMarkedDrugList()
                    }
                } else {
                    ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.drugList.count
    }
}
