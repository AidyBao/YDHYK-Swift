//
//  ZXReportAnalyseListViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/6.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 新增化验单-分析记录列表
class ZXReportAnalyseListViewController: ZXUIViewController {

    @IBOutlet weak var tblList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "分析记录"
        // Do any additional setup after loading the view.
        self.tblList.backgroundColor = UIColor.zx_subTintColor
        self.tblList.register(UINib.init(nibName: ZXReportListCell.NibName, bundle: nil), forCellReuseIdentifier: ZXReportListCell.reuseIdentifier)
        self.tblList.zx_addHeaderRefresh(showGif: true, target: self, action: #selector(zx_refresh))
        self.tblList.zx_addFooterRefresh(autoRefresh: true, target: self, action: #selector(zx_loadmore))
        self.tblList.mj_header.beginRefreshing()
        NotificationCenter.default.addObserver(self, selector: #selector(zx_refresh), name: ZXNotification.Report.deleteSuccess.zx_noticeName(), object: nil)
    }
    
    var dataList: Array<ZXReportListModel> = []
    var currentPage = 1
    override func zx_refresh() {
        currentPage = 1
        self.loadReportList()
    }
    
    override func zx_loadmore() {
        currentPage += 1
        self.loadReportList()
    }
    
    func loadReportList(showHUD: Bool = false) {
        if showHUD {
            ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
        }
        ZXReportAnalyseViewModel.list(pageNum: currentPage, pageSize: ZX.PageSize) { (success, code, list, errorMsg) in
            ZXHUD.hide(for: self.view, animated: true)
            self.tblList.mj_header.endRefreshing()
            self.tblList.mj_footer.endRefreshing()
            ZXEmptyView.hide(from: self.tblList)
            ZXEmptyView.hide(from: self.view)
            if success {
                if let list = list {
                    if self.currentPage == 1 {
                        self.dataList = list
                    } else {
                        self.dataList.append(contentsOf: list)
                    }
                    if self.dataList.count < ZX.PageSize {
                        self.tblList.mj_footer.endRefreshingWithNoMoreData()
                    }
                    self.tblList.reloadData()
                }
                if self.dataList.count == 0 {
                    ZXEmptyView.show(in: self.tblList, type: .noData, text: "无相关记录")
                }
            } else {
                if code != ZXAPI_LOGIN_INVALID {
                    if self.dataList.count > 0 {//之前有数据，再次获取时网络出错
                        if code == ZXAPI_HTTP_TIME_OUT {
                            ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                        } else {
                            ZXHUD.showFailure(in: self.view, text: "此时无法访问服务器", delay: ZX.HUDDelay)
                        }
                    } else {//第一次获取数据就出错 详细网络连接错误
                        if code == ZXAPI_HTTP_ERROR {
                            ZXEmptyView.show(in: self.view, type: .networkError, text: nil, retry: {
                                self.loadReportList(showHUD: true)
                            })
                        } else {
                            ZXEmptyView.show(in: self.tblList, type: .noData, text: "无相关记录")
                            ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                        }
                    }
                } else {
                    if self.dataList.count == 0 {
                        ZXEmptyView.show(in: self.tblList, type: .noData, text: "无相关记录")
                    }
                }
            }
        }
    }
}

extension ZXReportAnalyseListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ZXReportDetailViewController()
        detailVC.reportId = self.dataList[indexPath.section].reportId
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ZXReportListCell.height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

extension ZXReportAnalyseListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZXReportListCell.reuseIdentifier, for: indexPath) as! ZXReportListCell
        cell.reloadData(model: self.dataList[indexPath.section])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
