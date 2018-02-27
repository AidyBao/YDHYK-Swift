//
//  ZXAnalyseResultViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/21.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 化验单 - 分析结果
class ZXAnalyseResultViewController: ZXUIViewController {

    var reportId: String?
    var isAbnormal = false
    var pushFromNewReportVC = false
    var resultList: Array<ZXAnalyseResultItem> = []
    
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var lbTips: UILabel!
    @IBOutlet weak var lbTips2: UILabel!
    
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var tblList: UITableView!
    
    @IBOutlet weak var btnCreateNew: ZXUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "分析结果详情"
        self.view.backgroundColor = UIColor.zx_tintColor
        if !pushFromNewReportVC {
            self.zx_addNavBarButtonItems(textNames: ["分析记录"], font: nil, color: nil, at: .right)
        }
        self.tblList.register(UINib.init(nibName: ZXAnalyseResultCell.NibName, bundle: nil), forCellReuseIdentifier: ZXAnalyseResultCell.reuseIdentifier)
        self.tblList.rowHeight = UITableViewAutomaticDimension
        self.tblList.estimatedRowHeight = 100
        self.imgStatus.isHidden = true
        self.lbStatus.isHidden = true
        self.lbTips.isHidden = true
        self.lbTips2.isHidden = true
        self.btnCreateNew.backgroundColor = UIColor.zx_tintColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !onceLoad {
            onceLoad = true
            self.loadDetail(showHUD: true)
        }
    }
    
    override func zx_rightBarButtonAction(index: Int) {
        if let nav = self.navigationController {
            var popVc: UIViewController?
            for tVc in nav.viewControllers {
                if tVc is ZXReportAnalyseListViewController {
                    popVc = tVc
                    break
                }
            }
            if let popVc = popVc {
                self.navigationController?.popToViewController(popVc, animated: true)
            }
        }
    }
    
    func loadDetail(showHUD: Bool) {
        if let reportId = self.reportId {
            if showHUD {
                ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
            }
            ZXReportAnalyseViewModel.analyseResult(reportId: reportId, completion: { (success, code, itemList, errorMsg) in
                ZXHUD.hide(for: self.view, animated: false)
                ZXEmptyView.hide(from: self.view)
                ZXEmptyView.hide(from: self.tblList)
                if success {
                    if let list = itemList {
                        self.resultList = list
                    }
                    self.tblList.reloadData()
                    self.reloadUI()
                } else {
                    if code != ZXAPI_LOGIN_INVALID {
                        ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                    }
                }
            })
        } else {
            ZXHUD.showFailure(in: self.view, text: "化验单ID为空", delay: ZX.HUDDelay)
        }
    }
    
    func reloadUI() {
        self.imgStatus.isHidden = false
        self.lbStatus.isHidden = false
        self.lbTips.isHidden = false
        self.lbTips2.isHidden = false
        if self.resultList.count > 0 {
            imgStatus.isHighlighted = true
            lbStatus.isHighlighted = true
            lbStatus.text = "发现\(self.resultList.count)个异常点"
        } else {
            imgStatus.isHighlighted = false
            lbStatus.isHighlighted = false
            lbStatus.text = "未发现异常点"
        }
    }

    @IBAction func addNewReport(_ sender: Any) {
        if let nav = self.navigationController {
            var popVc: UIViewController?
            for tVc in nav.viewControllers {
                if tVc is ZXAddNewReportAnalyseViewController {
                    popVc = tVc
                    break
                }
            }
            if let popVc = popVc {
                self.navigationController?.popToViewController(popVc, animated: true)
            }
        }
    }
}

extension ZXAnalyseResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZXAnalyseResultCell.reuseIdentifier, for: indexPath) as! ZXAnalyseResultCell
        cell.reloadData(model: self.resultList[indexPath.row])
        return cell
    }
}
