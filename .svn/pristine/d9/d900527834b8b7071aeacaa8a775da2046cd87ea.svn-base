//
//  ZXReportTemplateSelectViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/22.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

typealias ZXTemplateCheckEnd = (_ list: Array<ZXCheckItemListModel>) -> Void

/// 化验单模板选择
class ZXReportTemplateSelectViewController: ZXUIViewController {

    var checkEnd: ZXTemplateCheckEnd?
    @IBOutlet weak var tblList: UITableView!
    
    var arrTemplates: Array<ZXConstDicModel> = []
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "模板"
        // Do any additional setup after loading the view.
        self.tblList.backgroundColor = UIColor.zx_subTintColor
        
        self.tblList.register(UINib.init(nibName: ZXTemplateItemCell.NibName, bundle: nil), forCellReuseIdentifier: ZXTemplateItemCell.reuseIdentifier)
        self.tblList.zx_addHeaderRefresh(showGif: true, target: self, action: #selector(zx_refresh))
        self.tblList.mj_header.beginRefreshing()
    }
    
    override func zx_refresh() {
        self.loadTemplates()
    }
    
    func loadTemplates() {
        ZXCommonViewModel.getConstDic(with: .checkTemplate) { (success, code, list, errorMsg) in
            self.tblList.mj_header.endRefreshing()
            ZXHUD.hide(for: self.view, animated: true)
            ZXEmptyView.hide(from: self.tblList)
            if success {
                self.arrTemplates = list ?? []
                self.reloadAction()
            } else {
                if code != ZXAPI_LOGIN_INVALID {
                    ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                }
            }
        }
    }
    
    func reloadAction() {
        if arrTemplates.count > 0 {
            self.zx_addNavBarButtonItems(textNames: ["完成"], font: nil, color: nil, at: .right)
        } else {
            ZXEmptyView.show(in: self.tblList, type: .noData, text: "暂无化验单模板")
            self.navigationItem.rightBarButtonItems = nil
        }
        self.tblList.reloadData()
    }
    //MARK: 获取模板检查项 并返回
    override func zx_rightBarButtonAction(index: Int) {
        if let indexPath = self.tblList.indexPathForSelectedRow {
            ZXHUD.showLoading(in: self.view, text: "获取模板检查项...", delay: 0)
            ZXReportAnalyseViewModel.checkItemListBy(templateKey: self.arrTemplates[indexPath.row].key, completion: { (success, code, list, errorMsg) in
                ZXHUD.hide(for: self.view, animated: true)
                if success {
                    if let list = list,list.count > 0 {
                        self.navigationController?.popViewController(animated: true)
                        self.checkEnd?(list)
                    } else {
                        ZXHUD.showFailure(in: self.view, text: "该模板检查项为空", delay: ZX.HUDDelay)
                    }
                } else {
                    if code == ZXAPI_LOGIN_INVALID {
                        ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                    }
                }
            })
        } else {
            ZXHUD.showFailure(in: self.view, text: "请选择模板", delay: ZX.HUDDelay)
        }
    }
}

extension ZXReportTemplateSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}

extension ZXReportTemplateSelectViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZXTemplateItemCell.reuseIdentifier, for: indexPath) as! ZXTemplateItemCell
        cell.lbName.text = self.arrTemplates[indexPath.row].value
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTemplates.count
    }
}
