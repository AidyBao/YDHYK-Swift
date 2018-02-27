//
//  ZXDrugSearchViewController.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/5/16.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 药品检索
class ZXDrugSearchViewController: ZXSTUIViewController {
    @IBOutlet var zxGoodsListDD: ZXGoodsListDD!
    
    @IBOutlet weak var nav1View: UIView!
    @IBOutlet weak var nav2View: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var maskView: UIView!
    
    @IBOutlet weak var tblDrugList: UITableView!

    var currentPage = 1
    var searchText:String?
    var autoSearch = false
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not init yet")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nav1View.backgroundColor = UIColor.zx_tintColor
        self.nav2View.backgroundColor = UIColor.zx_tintColor
        
        self.maskView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        self.maskView.alpha = 0
        self.maskView.isHidden = true

        self.searchView.backgroundColor = UIColor.zx_tintColor
        self.searchView.addSubview(self.searchBar)
//        self.searchBar.snp.makeConstraints { (make) in
//            make.top.left.right.bottom.equalTo(self.searchView)
//        }
        
        self.searchBar.delegate = self
        
        self.view.backgroundColor = UIColor.zx_tintColor

        zxGoodsListDD.source = self
        
        self.tblDrugList.backgroundColor = UIColor.zx_subTintColor
        self.tblDrugList.register(UINib(nibName: ZXStoreDrugCell.NibName, bundle: nil), forCellReuseIdentifier: ZXStoreDrugCell.reuseIdentifier)
        //Refresh
        self.tblDrugList.zx_addHeaderRefresh(showGif: true, target: self, action: #selector(self.zx_refresh))
        //LoadMore
        self.tblDrugList.zx_addFooterRefresh(autoRefresh: true, target: self, action: #selector(self.zx_loadmore))
        
        //KeyboardNotification
        self.zx_addKeyboardNotification()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.searchBar.frame = CGRect(x: 0, y: 0, width: self.searchView.frame.size.width, height: self.searchView.frame.size.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !autoSearch {
            self.searchBar.becomeFirstResponder()
        }
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tblDrugList.reloadData() // 避免其他界面修改了数量
        if autoSearch,!onceLoad {
            onceLoad = false
            searchBar.text = searchText
            self.fetchDrugList(true)
        }
    }

    @IBAction func cancelAction(_ sender: Any) {
        self.searchBar.resignFirstResponder()
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func jumpToDrugCart(_ sender: UIButton) {
//        let cart = ZXDrugCartViewController()
//        self.navigationController?.pushViewController(cart, animated: true)
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
        self.view.endEditing(true)
        if showHUD {
            ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
        } else {
            ZXCommonUtils.showNetworkActivityIndicator(true)
        }
        ZXStoreHomeViewModel.searchDrugList(self.searchText, categoryId: nil, pageNum: currentPage, pageSize: Int(ZX.PageSize), storeId: ZXStoreParams.storeId, completion: { (code, success, listModel, errorMsg) in
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
                    ZXEmptyView.show(in: self.tblDrugList, type: .networkError, text: nil, retry: { [unowned self]  in
                        self.fetchDrugList(true)
                    })
                } else {
                    ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                }
            }
        })
    }
    
    //MARK: - serach bar
    let searchBar:UISearchBar = {
        let _searchBar = UISearchBar.init()
        let placeHoderlStr = "搜索药品名、适应症或功能主治"
        _searchBar.autocapitalizationType = .none
        _searchBar.autocorrectionType = .no
        _searchBar.backgroundImage = UIImage()
        if #available(iOS 9.0, *) {
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.font.rawValue: UIFont.zx_titleFont(UIFont.zx_bodyFontSize),NSAttributedStringKey.foregroundColor.rawValue: UIColor.zx_textColorTitle]
            let attrStr = NSAttributedString.init(string: placeHoderlStr, attributes: [NSAttributedStringKey.font: UIFont.zx_titleFont(UIFont.zx_bodyFontSize),NSAttributedStringKey.foregroundColor: UIColor.zx_textColorMark])
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = attrStr
        } else {
            // Fallback on earlier versions
            _searchBar.placeholder = placeHoderlStr
        }
        return _searchBar
    }()
    
    //MARK: - Keyboard Action
    override func zx_keyboardWillShow(duration dt: Double, userInfo: Dictionary<String, Any>) {
        self.maskView.isHidden = false
        UIView.animate(withDuration: dt, animations: {
            self.maskView.alpha = 1.0
        }, completion: nil)
    }
    
    override func zx_keyboardWillHide(duration dt: Double, userInfo: Dictionary<String, Any>) {
        UIView.animate(withDuration: dt, animations: {
            self.maskView.alpha = 0
        }) { (finished) in
            self.maskView.isHidden = true
        }
    }
}

extension ZXDrugSearchViewController:UISearchBarDelegate {
    //MARK: - 检索点击
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchText = searchBar.text
        currentPage = 1
        self.fetchDrugList(true)
        self.view.endEditing(true)
    }
}

extension ZXDrugSearchViewController: ZXStoreDrugCellDelegate {
    //MARK: - 商品数量操作
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