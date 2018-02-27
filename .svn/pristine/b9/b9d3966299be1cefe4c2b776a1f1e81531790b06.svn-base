//
//  ZXItemListSelectViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/23.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 检测项选择
class ZXItemListSelectViewController: ZXUIViewController {
    var checkEnd: ZXTemplateCheckEnd?
    var sortIndex: Array<String> = []
    @IBOutlet weak var tblList: UITableView!
    var arrItems: Array<ZXCheckItemListModel> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "添加检查项目"
        self.arrItems = ZXReportAnalyseViewModel.zx_allCheckItemListCache ?? []
        // Do any additional setup after loading the view.
        self.tblList.backgroundColor = UIColor.zx_subTintColor
        
        self.tblList.register(UINib.init(nibName: ZXTemplateItemCell.NibName, bundle: nil), forCellReuseIdentifier: ZXTemplateItemCell.reuseIdentifier)
        self.tblList.zx_addHeaderRefresh(showGif: true, target: self, action: #selector(zx_refresh))
        self.tblList.sectionIndexColor = UIColor.zx_textColorTitle
        self.tblList.sectionIndexBackgroundColor = .clear

        if arrItems.count > 0 {
            self.zx_addNavBarButtonItems(textNames: ["完成"], font: nil, color: nil, at: .right)
            self.configSortIndex()
        } else {
            ZXEmptyView.show(in: self.tblList, type: .noData, text: "无检查项数据")
        }
    }
    
    override func zx_rightBarButtonAction(index: Int) {
        if let indexPaths = self.tblList.indexPathsForSelectedRows {
            var list: Array<ZXCheckItemListModel> = []
            for indexPath in indexPaths {
                list.append(self.arrItems[indexPath.row])
            }
            self.navigationController?.popViewController(animated: true)
            checkEnd?(list)
        } else {
            ZXHUD.showFailure(in: self.view, text: "请选择检查项", delay: ZX.HUDDelay)
        }
    }
    
    func reloadUI() {
        if arrItems.count > 0 {
            self.zx_addNavBarButtonItems(textNames: ["完成"], font: nil, color: nil, at: .right)
        } else {
            self.navigationItem.rightBarButtonItems = nil
        }
        self.configSortIndex()
        self.tblList.reloadData()
    }
    //构建索引
    func configSortIndex() {
        self.sortIndex.removeAll()
        if self.arrItems.count > 0 {
            var indexSet: Set<String> = Set()
            for item in self.arrItems {
                indexSet.insert(item.zx_pinyin.substring(to: 1).uppercased())
            }
            self.sortIndex = Array.init(indexSet)
            self.sortIndex.sort { $0 < $1 }
        }
    }
    
    override func zx_refresh() {
        ZXReportAnalyseViewModel.checkItemListBy(templateKey: nil) { (success, code, list, errorMsg) in
            self.tblList.mj_header.endRefreshing()
            ZXEmptyView.hide(from: self.tblList)
            if success {
                self.arrItems = list ?? []
                if self.arrItems.count == 0 {
                    ZXEmptyView.show(in: self.tblList, type: .noData, text: "无检查项数据")
                }
                self.reloadUI()
            } else {
                if code != ZXAPI_LOGIN_INVALID {
                    ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                }
            }
        }
    }
}

extension ZXItemListSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        if let index = self.sortIndexBy(key: title) {
            tableView.scrollToRow(at: IndexPath.init(row: index, section: 0), at: .none, animated: true)
        }
        return NSNotFound
    }
    
    fileprivate func sortIndexBy(key: String) -> Int? {
        var index: Int?
        for (idx,item) in self.arrItems.enumerated() {
            if item.zx_pinyin.hasPrefix(key.lowercased()) {
                index = idx
                break
            }
        }
        return index
    }
}

extension ZXItemListSelectViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZXTemplateItemCell.reuseIdentifier, for: indexPath) as! ZXTemplateItemCell
        cell.lbName.text = self.arrItems[indexPath.row].itemName
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrItems.count
    }
    
    //
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.sortIndex
    }
}

