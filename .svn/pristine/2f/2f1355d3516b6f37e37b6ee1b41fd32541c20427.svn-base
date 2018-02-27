//
//  ZXDiscoverRootViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/1.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
enum ZXScrollDirection {
    case up
    case down
    case none
}

class ZXDiscoverTableView: UITableView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if point.y < 0 {
            return nil
        }
        return self
    }
}

class ZXDiscoverRootViewController: ZXUIViewController {
    
    var currentPage = 1
    var arrDiscoverList: Array<ZXDiscoverModel> = []
    var location = CLLocation.init(latitude: ZX.Location.latitude, longitude: ZX.Location.longitude)

    
    @IBOutlet weak var topMenuContentView: UIView!
    @IBOutlet weak var ccvTopOffset: NSLayoutConstraint!
    @IBOutlet weak var ccvTopMenu: UICollectionView!
    @IBOutlet weak var tblList: ZXDiscoverTableView!
    var btnScan: UIButton!
    var btnQRCode: UIButton!
    var leftMenuView: UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 88, height: 44))
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    var btnTool: UIButton!
    var rightMenuView: UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "发现"
        self.hidesBottomBarWhenPushed = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.zx_addNavBarButtonItems(textNames: ["购药"], font: nil, color: nil, at: .right)
        self.topMenuContentView.backgroundColor = UIColor.zx_tintColor
        self.ccvTopMenu.backgroundColor = UIColor.clear
        self.ccvTopMenu.register(UINib.init(nibName: ZXMenuCCVCell.NibName, bundle: nil), forCellWithReuseIdentifier: ZXMenuCCVCell.reuseIdentifier)
        self.ccvTopMenu.delegate = self
        self.ccvTopMenu.dataSource = self
        
        self.tblList.backgroundColor = .clear
        self.tblList.delegate = self
        self.tblList.dataSource = self
        self.tblList.contentInset = UIEdgeInsetsMake(100, 0, 0, 0)
        self.tblList.scrollIndicatorInsets = UIEdgeInsetsMake(100, 0, 0, 0)
        self.tblList.showsHorizontalScrollIndicator = false
        self.tblList.register(UINib.init(nibName: ZXDiscoverSamllTypeCell.NibName, bundle: nil), forCellReuseIdentifier: ZXDiscoverSamllTypeCell.reuseIdentifier)
        self.tblList.register(UINib.init(nibName: ZXDiscoverBigTypeCell.NibName, bundle: nil), forCellReuseIdentifier: ZXDiscoverBigTypeCell.reuseIdentifier)
        self.tblList.register(ZXEmptyHeader.self, forHeaderFooterViewReuseIdentifier: ZXEmptyHeader.reuseIdentifier)
        self.tblList.zx_addHeaderRefresh(showGif: true, target: self, action: #selector(zx_refresh))
        self.tblList.zx_addFooterRefresh(autoRefresh: true, target: self, action: #selector(zx_loadmore))
        self.tblList.mj_header.ignoredScrollViewContentInsetTop = -5
        self.tblList.mj_header.isHidden = true
        //NavBarLeft
        btnScan = UIButton.init(type: .custom)
        btnScan.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btnScan.tag = 10
        btnScan.addTarget(self, action: #selector(topMenuButtonAction(_:)), for: .touchUpInside)
        btnScan.contentHorizontalAlignment = .left
        btnScan.setImage(#imageLiteral(resourceName: "btn-join-small"), for: .normal)
        leftMenuView.addSubview(btnScan)
        
        btnQRCode = UIButton.init(type: .custom)
        btnQRCode.frame = CGRect(x: 44, y: 0, width: 44, height: 44)
        btnQRCode.setImage(#imageLiteral(resourceName: "btn-test-small"), for: .normal)
        btnQRCode.tag = 11
        btnQRCode.contentHorizontalAlignment = .left
        btnQRCode.addTarget(self, action: #selector(topMenuButtonAction(_:)), for: .touchUpInside)
        leftMenuView.addSubview(btnQRCode)
        self.zx_addNavBarButtonItems(customView: self.leftMenuView, at: .left)
        //NavBarRight
        let btnTool = UIButton.init(type: .custom)
        btnTool.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btnTool.contentHorizontalAlignment = .right
        btnTool.setImage(#imageLiteral(resourceName: "btn-tool-smalll"), for: .normal)
        btnTool.tag = 12
        btnTool.addTarget(self, action: #selector(topMenuButtonAction(_:)), for: .touchUpInside)
        rightMenuView.addSubview(btnTool)
        self.zx_addNavBarButtonItems(customView: self.rightMenuView, at: .right)
        
        self.setNavBarAlpha(0)
        self.setNavbarMenu(hidden: true)
        
        if #available(iOS 11.0, *) {
            self.tblList.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = false
            self.edgesForExtendedLayout = []
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !onceLoad {
            onceLoad = true
            self.loadDiscoverList(showHUD: true)
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.registRemoteNotification()
            }
        }
        self.startTrackingScroll = true
        
        if CLLocationManager.locationServicesEnabled() {
            let status = CLLocationManager.authorizationStatus()
            if status == .authorizedAlways || status == .authorizedWhenInUse {
                ZXLocationUtils.shareInstance.checkCurrentLocation(completion: { (status, location) in
                    if let location = location {
                        self.location = location
                        self.pasteBoardCheck()
                    } else {
                        self.pasteBoardCheck()
                    }
                })
            } else {
                self.pasteBoardCheck()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.startTrackingScroll = false
    }
    
    override func zx_rightBarButtonAction(index: Int) {
        let storeVC = ZXStoreRootViewController.configVC(storeId: "2000002", memberId: ZXUser.user.memberId, token: ZXUser.user.userToken)
        self.navigationController?.pushViewController(storeVC, animated: true)
    }
    
    override func zx_refresh() {
        currentPage = 1
        self.tblList.mj_footer.resetNoMoreData()
        self.loadDiscoverList(showHUD: false)
    }
    
    override func zx_loadmore() {
        currentPage += 1
        self.loadDiscoverList(showHUD: false)
    }
    
    func loadDiscoverList(showHUD: Bool) {
        if showHUD {
            ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
        }
        ZXDiscoverViewModel.loadList(pageNum: currentPage, pageSize: ZX.PageSize) { (success, code, list, errorMsg) in
            ZXHUD.hide(for: self.view, animated: true)
            ZXEmptyView.hide(from: self.tblList)
            ZXEmptyView.hide(from: self.view)
            self.tblList.mj_header.endRefreshing()
            self.tblList.mj_footer.endRefreshing()
            if success {
                if let list = list {
                    if self.currentPage == 1 {
                        self.arrDiscoverList = list
                    } else {
                        self.arrDiscoverList.append(contentsOf: list)
                    }
                    if self.arrDiscoverList.count < ZX.PageSize {
                        self.tblList.mj_footer.endRefreshingWithNoMoreData()
                    }
                    self.tblList.reloadData()
                }
                if self.arrDiscoverList.count == 0 {
                    ZXEmptyView.show(in: self.tblList, type: .noData, text: "没有新资讯")
                }
            } else {
                if code != ZXAPI_LOGIN_INVALID {
                    if self.arrDiscoverList.count > 0 {//之前有数据，再次获取时网络出错
                        if code == ZXAPI_HTTP_TIME_OUT {
                            ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                        } else {
                            ZXHUD.showFailure(in: self.view, text: "此时无法访问服务器", delay: ZX.HUDDelay)
                        }
                    } else {//第一次获取数据就出错 详细网络连接错误
                        if code == ZXAPI_HTTP_ERROR {
                            ZXEmptyView.show(in: self.view, type: .networkError, text: nil, retry: {
                                self.loadDiscoverList(showHUD: true)
                            })
                        } else {
                            ZXEmptyView.show(in: self.tblList, type: .noData, text: "没有新资讯")
                            ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                        }
                    }
                }else{
                    if self.arrDiscoverList.count == 0 {
                        ZXEmptyView.show(in: self.tblList, type: .noData, text: "没有新资讯")
                    }
                }
            }
        }
    }
    
    //滚动相关
    var oldOffsetY: CGFloat = 0
    var newOffsetY: CGFloat = 0
    var currentOffsetY: CGFloat = 0
    var startTrackingScroll = true // 是否监测ScrollView滚动
    var isDecelerating = false
    var direction: ZXScrollDirection = .none
}

extension ZXDiscoverRootViewController {
    @objc func topMenuButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 10://MARK: - 加入会员
            ZXJoinLeadViewController.checkShow(completion: {
                let scanVC = ZXQRCodeScanViewController()
                self.navigationController?.pushViewController(scanVC, animated: true)
            })
        case 11://MARK: - 验证会员
            let memberQRCodeInfoVC = ZXMyQRCodeViewController()
            self.navigationController?.pushViewController(memberQRCodeInfoVC, animated: true)
        case 12://MARK: - 智能工具
            let smartToolVC = ZXSmartToolViewController()
            self.navigationController?.pushViewController(smartToolVC, animated: true)
        default:
            break
        }
    }
    
    fileprivate func pasteBoardCheck() {
        let pasteBoard = UIPasteboard.general
        if let result = pasteBoard.string {
            if (result.range(of: ZX.QRCode_ContainText) != nil)  {
                if let storeIdRange = result.range(of: "drugstoreid=[\\d]*", options: .regularExpression, range: nil, locale: nil) {
                    let userIdRange = result.range(of: "userid=[\\d]*", options: .regularExpression, range: nil, locale: nil)
                    var storeId = result.substring(with: storeIdRange)
                    storeId = storeId.replacingOccurrences(of: "drugstoreid=", with: "")
                    var sId = (storeId as NSString).longLongValue
                    if sId < 2000000 {//ID 小于2,000,000
                        sId += 2000000
                    }
                    storeId = "\(sId)"
                    var userId: String?
                    if let uRange = userIdRange {
                        userId = result.substring(with: uRange)
                        userId = userId?.replacingOccurrences(of: "userid=", with: "")
                    }
                    ZXStoreMemberViewModel.validMember(storeId: storeId, completion: { (isMember, success, storeName) in
                        if success {
                            if !isMember {
                                ZXAlertUtils.showAlert(wihtTitle: nil, message: "是否加入\(storeName)会员", buttonTexts: ["取消", "加入"], action: { (index) in
                                    if index == 1 {
                                        self.joinMemberTo(storeId: storeId, userId: userId)
                                    }
                                })
                            } else {
                                let store = ZXStoreRootViewController.configVC(storeId: storeId, memberId: ZXUser.user.memberId, token: ZXUser.user.userToken)
                                self.navigationController?.pushViewController(store, animated: true)
                            }
                        }
                    })
                }
            }
        }
        pasteBoard.string = ""
    }//
//    [ZXJoinMemberViewModel isStoreMember:[NSString stringWithFormat:@"%@",@(sId)] memberId:[ZXGlobalData shareInstance].memberId token:[ZXGlobalData shareInstance].userToken completion:^(BOOL isMember, NSString *storeName, BOOL success) {
//    if (success) {
//    if (!isMember) {
//    [ZXAlertUtils showAAlertMessage:[NSString stringWithFormat:@"是否加入[%@]会员",storeName] title:@"提示" buttonTexts:@[@"取消",@"加入"] buttonAction:^(int buttonIndex) {
//    if (buttonIndex == 1) {
//    [self joinMemberToStoreId:[NSString stringWithFormat:@"%@",@(sId)] recommendUserId:userId];
//    }
//    }];
//    } else {
//    ZXStoreRootViewController * webStore = [ZXStoreRootViewController configVCWith:storeId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken]];
//    NSMutableArray *ViewCtr = [NSMutableArray arrayWithObject:[self.navigationController.viewControllers firstObject]];
//    [ViewCtr addObject:webStore];
//    [self.navigationController setViewControllers:ViewCtr animated:YES];
//    //[webStore.navigationController setNavigationBarHidden:true animated:true];
//    }
//    }
//    }];
//    
//    pasteBoard.string = @"";
//    
//    }
//    }
//    }

    func joinMemberTo(storeId: String,userId: String?) {
        ZXCommonUtils.showNetworkActivityIndicator(true)
        ZXStoreMemberViewModel.joinTo(storeId: storeId, userId: userId, location: self.location) { (isNew, success, code, errorMsg) in
            ZXCommonUtils.showNetworkActivityIndicator(false)
            if success {
                NotificationCenter.default.post(name: ZXNotification.Member.joinSuccess.zx_noticeName(), object: ["storeId": storeId])
                ZXCommonUtils.showNetworkActivityIndicator(true)
                //获取店铺详情并跳转
                ZXStoreMemberViewModel.storeShortInfo(storeId: storeId, completion: { (success, code, model, errorMsg) in
                    ZXCommonUtils.showNetworkActivityIndicator(false)
                    if success {
                        if let store = model {
                            if !isNew { //跳转到成功界面
                                let successVC = ZXJoinSuccessViewController()
                                successVC.storeInfo = store
                                self.navigationController?.pushViewController(successVC, animated: true)
                                //获取历史未失效现金券 失败不做二次处理
                                ZXStoreMemberViewModel.dispatchHistoryCoupon(storeId: storeId, to: ZXUser.user.memberId)
                                //历史促销信息
                                ZXStoreMemberViewModel.deliverHistoryPromotion(storeId: storeId, to: ZXUser.user.memberId)
                            } else { //直接进入店铺
                                let store = ZXStoreRootViewController.configVC(storeId: store.storeId, memberId: ZXUser.user.memberId, token: ZXUser.user.userToken)
                                self.navigationController?.pushViewController(store, animated: true)
                            }
                        }
                    }
                })
            }
        }
    }
}
