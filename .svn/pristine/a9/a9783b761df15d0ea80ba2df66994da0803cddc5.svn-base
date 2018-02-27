//
//  ZXDrugListViewController.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/5/16.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 药品列表 - 药品分类列表
class ZXDrugListViewController: ZXSTUIViewController {
    
    @IBOutlet var zxGoodsListDD: ZXGoodsListDD!
    @IBOutlet weak var tblDrugList: UITableView!
    
    var category:ZXCategoryTreeModel?
    var currentPage = 1
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tblDrugList.backgroundColor = UIColor.zx_subTintColor
        self.tblDrugList.register(UINib(nibName: ZXStoreDrugCell.NibName, bundle: nil), forCellReuseIdentifier: ZXStoreDrugCell.reuseIdentifier)
        zxGoodsListDD.source = self
        //Refresh
        self.tblDrugList.zx_addHeaderRefresh(showGif: true, target: self, action: #selector(self.zx_refresh))
        //LoadMore
        self.tblDrugList.zx_addFooterRefresh(autoRefresh: true, target: self, action: #selector(self.zx_loadmore))
        self.zx_addNavBarButtonItems(imageNames: ["zx-search-white"], useOriginalColor: false, at: .right)
    }
    
    override func zx_rightBarButtonAction(index: Int) {
        let search = ZXDrugSearchViewController()
        self.navigationController?.pushViewController(search, animated: true)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let cat = self.category {
            self.title = cat.name
            if !onceLoad {
                onceLoad = true
                self.fetchDrugList(true)
            }
        } else {
            ZXHUD.showFailure(in: self.view, text: "分类信息为空,无法获取相关药品数据", delay: ZX.HUDDelay)
        }

        self.tblDrugList.reloadData() // 避免其他界面修改了数量
    }
    
    //MARK: - 下拉刷新
    override func zx_refresh() {
        currentPage = 1
        self.fetchDrugList(false)
    }
    //MARK: - 加载更多
    override func zx_loadmore() {
        currentPage += 1
        self.fetchDrugList(false)
    }
    
    func fetchDrugList(_ showHUD:Bool) {
        if let cat = category {
            if showHUD {
                ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
            } else {
                ZXCommonUtils.showNetworkActivityIndicator(true)
            }
            ZXStoreHomeViewModel.searchDrugList(nil, categoryId: "\(cat.cid)", pageNum: currentPage, pageSize: Int(ZX.PageSize), storeId: ZXStoreParams.storeId, completion: { (code, success, listModel, errorMsg) in
                ZXHUD.hide(for: self.view , animated: true)
                ZXCommonUtils.showNetworkActivityIndicator(false)
                ZXEmptyView.hide(from: self.view)
                ZXEmptyView.hide(from: self.tblDrugList)
                self.tblDrugList.mj_header.endRefreshing()
                self.tblDrugList.mj_footer.endRefreshing()
                self.tblDrugList.mj_footer.resetNoMoreData()
                if success {
                    var hasData:Bool = true
                    if self.currentPage == 1 {
                        self.zxGoodsListDD.drugList.removeAll()
                        if let listModel = listModel,listModel.count > 0 {
                            self.zxGoodsListDD.drugList = listModel
                            if listModel.count < ZX.PageSize {
                                self.tblDrugList.mj_footer.endRefreshingWithNoMoreData()
                            }
                        } else {
                            ZXEmptyView.show(in: self.tblDrugList, type: .noData, text: "暂无相关药品数据")
                            self.tblDrugList.mj_footer.endRefreshingWithNoMoreData()
                            hasData = false
                        }
                    } else{
                        if let listModel = listModel,listModel.count > 0 {
                            self.zxGoodsListDD.drugList.append(contentsOf: listModel)
                            if listModel.count < ZX.PageSize {
                                self.tblDrugList.mj_footer.endRefreshingWithNoMoreData()
                            }
                        } else {
                            self.tblDrugList.mj_footer.endRefreshingWithNoMoreData()
                        }
                    }
                    self.tblDrugList.reloadData()
                    if self.currentPage == 1,hasData {
                        if let listModel = listModel,listModel.count > 0 {
                            self.tblDrugList.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: true)
                        }
                    }
                } else if code != ZXAPI_LOGIN_INVALID {
                    if self.currentPage == 1 {
                        ZXEmptyView.show(in: self.view, type: .networkError, text: nil, retry: { [unowned self]  in
                            self.fetchDrugList(true)
                        })
                    } else {
                        ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                    }
                }
            })
        }
    }
}

extension ZXDrugListViewController: ZXStoreDrugCellDelegate {
    //MARK: - 添加数量
    func zxStoreDrugCell(_ cell: UITableViewCell, controlType type: ZXGrugNumControlType) {
        if let indexPath = self.tblDrugList.indexPath(for: cell) {
            let model = self.zxGoodsListDD.drugList[indexPath.row]
            let sid = model.baseDrugId
            if type == .plus {
                ZXCart.cart.plus(storeId: model.drugstoreId, drugId: sid)
            } else {
                ZXCart.cart.sub(storeId: model.drugstoreId, drugId: sid)
            }
        }
    }
}
