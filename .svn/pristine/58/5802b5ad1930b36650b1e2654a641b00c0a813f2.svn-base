//
//  ZXDrugDetailInfoViewController.swift
//  YDHYK
//
//  Created by screson on 2017/10/16.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 商品详情 、 店铺详情
class ZXDrugDetailInfoViewController: ZXSTUIViewController,UIScrollViewDelegate {
    static func postStoreUIUpdateNotice() {
        NotificationCenter.default.post(name: NSNotification.Name.init("StoreUIUpdate"), object: nil)
    }
    static func postDrugUIUpdateNotice() {
        NotificationCenter.default.post(name: NSNotification.Name.init("DrugUIUpdate"), object: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .default }
    
    var topMenu: ZXSegment!
    var goodsShortModel: ZXDrugModel?
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var bottomMenuView: UIView!
    
    @IBOutlet weak var btnMark: UIButton!
    @IBOutlet weak var btnContact: UIButton!
    @IBOutlet weak var btnBuyNow: ZXRButton!
    @IBOutlet weak var btnAddtoCart: ZXRButton!

    
    var drugCommonInfo: ZXDurgCommonInfoViewController!
    var webInfomation: ZXDrugInfosViewController!
    var storeInfo: ZXDrugStoreInfoViewController!
    
    var goodsDetailModel: ZXDrugDetailModel?
    fileprivate var sSpec: ZXDrugSpecModel?
    var selectedSpec:ZXDrugSpecModel? {
        set {
            self.sSpec = newValue
        }
        get {
            if let sSpec = sSpec {
                return sSpec
            } else if let model = self.goodsDetailModel {
                return model.zx_defaultSpec
            }
            return nil
        }
    }
    
    var specIndex:Int {//规格Index
        get {
            if let selectedSpec = selectedSpec,let specs = self.goodsDetailModel?.zx_specList {
                var index = 0
                for s in specs {
                    if s.baseDrugId == selectedSpec.baseDrugId {
                        return index
                    }
                    index += 1
                }
            }
            return 0
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //
        self.bottomMenuView.isHidden = true
        self.btnContact.setTitleColor(UIColor.zx_textColorTitle, for: .normal)
        self.btnMark.setTitleColor(UIColor.zx_textColorTitle, for: .normal)
        self.btnMark.setTitleColor(UIColor.init(red: 248 / 255.0, green: 171 / 255.0, blue: 3 / 255.0, alpha: 1.0), for: .selected)
        self.btnMark.setTitle("收藏", for: .normal)
        self.btnMark.setTitle("已收藏", for: .selected)
        self.btnMark.setImage(UIImage.init(named: "store-unmark"), for: .normal)
        self.btnMark.setImage(UIImage.init(named: "store-mark"), for: .highlighted)
        self.btnMark.setImage(UIImage.init(named: "store-mark"), for: .selected)

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = []
        topMenu = ZXSegment.init(origin: CGPoint.zero
            , mWidth: ZXBOUNDS_WIDTH - 100)
        topMenu.offsetX = 0
        topMenu.dataSource = self
        topMenu.delegate = self
        
        //self.mainScrollView.contentSize = CGSize(width: ZXBOUNDS_WIDTH * 3, height: self.view.frame.size.height)
        self.mainScrollView.bounces = false
        self.mainScrollView.backgroundColor = UIColor.zx_tintColor
        
        self.navigationItem.titleView = topMenu
        
        self.drugCommonInfo = ZXDurgCommonInfoViewController()
        self.drugCommonInfo.delegate = self
        self.mainScrollView.addSubview(self.drugCommonInfo.view)
        self.addChildViewController(self.drugCommonInfo)
        
        self.webInfomation = ZXDrugInfosViewController()
        self.mainScrollView.addSubview(self.webInfomation.view)
        self.addChildViewController(self.webInfomation)
        
        self.storeInfo = ZXDrugStoreInfoViewController()
        self.mainScrollView.addSubview(self.storeInfo.view)
        self.addChildViewController(self.storeInfo)
        
        self.mainScrollView.delegate = self
        self.drugCommonInfo.shortModel = self.goodsShortModel
        
        NotificationCenter.default.addObserver(self, selector: #selector(zxUpdateStatusBar), name: "ZXStatusBarUpdate".zx_noticeName(), object: nil)
    }
    
    @objc func zxUpdateStatusBar() {
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let oFrame = self.mainScrollView.frame
        self.mainScrollView.contentSize = CGSize(width: ZXBOUNDS_WIDTH * 3, height: oFrame.size.height)
        drugCommonInfo.view.frame = CGRect(x: 0, y: 0, width: oFrame.size.width, height: oFrame.size.height)
        webInfomation.view.frame = CGRect(x: ZXBOUNDS_WIDTH, y: 0, width: oFrame.size.width, height: oFrame.size.height)
        storeInfo.view.frame = CGRect(x: ZXBOUNDS_WIDTH * 2, y: 0, width: oFrame.size.width, height: oFrame.size.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.zx_setNavBarSubViewsColor(UIColor.zx_textColorTitle)
        self.zx_setNavBarBackgroundColor(UIColor.init(red: 248 / 255.0, green: 246 / 255.0, blue: 248 / 255.0, alpha: 1.0))
        
        if !onceLoad {
            onceLoad = true
            self.drugCommonInfo.fetchDrugDetail(showHUD: true, finished: { (drug,store) in
                self.webInfomation.goodsDetailModel = drug
                self.storeInfo.detailInfo = store
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let last = self.navigationController?.viewControllers.last {
            if !(last is ZXDrugDetailInfoViewController) {
                last.zx_setNavBarSubViewsColor(UIColor.white)
                last.zx_setNavBarBackgroundColor(UIColor.zx_navBarColor)
                let temp = last.title
                last.title = nil
                last.title = temp
            }
        }
        super.viewWillDisappear(animated)
    }
    
    /// 加入购物车
    ///
    /// - Parameter sender:
    @IBAction func addtoCartAction(_ sender: Any) {
        let specsVC = ZXDrugSpecsSelectViewController()
        specsVC.type = .addToCart
        specsVC.delegate = self
        specsVC.drugDetailInfo = self.goodsDetailModel
        specsVC.selectedIndex = self.specIndex
        self.present(specsVC, animated: true, completion: nil)
    }
    
    /// 立即购买
    ///
    /// - Parameter sender:
    @IBAction func buyNowAction(_ sender: Any) {
        let specsVC = ZXDrugSpecsSelectViewController()
        specsVC.type = .buyNow
        specsVC.delegate = self
        specsVC.drugDetailInfo = self.goodsDetailModel
        specsVC.selectedIndex = self.specIndex
        self.present(specsVC, animated: true, completion: nil)
    }

    /// 联系客服
    ///
    /// - Parameter sender:
    @IBAction func contactAction(_ sender: Any) {
        if let model = ZXStoreParams.storeInfo,model.tel.count > 0 {
            ZXCommonUtils.call(model.tel, failed: { (str) in
                ZXHUD.showFailure(in: self.view, text: str, delay: ZX.HUDDelay)
            })
        } else {
            ZXHUD.showFailure(in: self.view, text: "暂无相关联系电话", delay: ZX.HUDDelay)
        }
    }
    
    //MARK: - 收藏
    @IBAction func markAction(_ sender: Any) {
        if let spec = self.selectedSpec,let model = self.goodsDetailModel {
            ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
            ZXDrugViewModel.markDrug(self.btnMark.isSelected ? false : true, drugId: spec.baseDrugId, storeId:model.drugstoreId , collectPrice: "\(spec.price)", completion: { (c, s, errorMsg) in
                ZXHUD.hide(for: self.view, animated: true)
                if s {
                    if self.btnMark.isSelected {
                        ZXHUD.showSuccess(in: self.view, text: "取消收藏", delay: ZX.HUDDelay)
                        self.btnMark.isSelected = false
                        self.selectedSpec?.isColl = false
                    } else {
                        ZXHUD.showSuccess(in: self.view, text: "已收藏", delay: ZX.HUDDelay)
                        self.btnMark.isSelected = true
                        self.selectedSpec?.isColl = true
                    }
                } else {
                    if c != ZXAPI_LOGIN_INVALID {
                        ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                    }
                }
            })
        } else {
            ZXHUD.showFailure(in: self.view, text: "药品信息不存在", delay: ZX.HUDDelay)
        }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(floor(scrollView.contentOffset.x / ZXBOUNDS_WIDTH))
        self.topMenu.slider(to: index)
    }
}
//MARK: - 药品详情界面操作Delegate
extension ZXDrugDetailInfoViewController: ZXDrugCommonInfoDelegate {
    //药品详情数据
    func zxDrugCommonInfoReloadGoodsDetail(_ detail: ZXDrugDetailModel?) {
        self.selectedSpec = nil
        self.goodsDetailModel = detail
        if let model = self.goodsDetailModel {
            self.bottomMenuView.isHidden = false
            if model.isPrescription == 1 {//处方药
                self.btnAddtoCart.isEnabled = false
                self.btnBuyNow.isEnabled = false
            } else {
                self.btnAddtoCart.isEnabled = true
                self.btnBuyNow.isEnabled = true
            }
            
            if let spec = self.selectedSpec,spec.isColl {
                self.btnMark.isSelected = true
            } else {
                self.btnMark.isSelected = false
            }
            
            self.drugCommonInfo.selectedSpec = self.selectedSpec//
        }
    }
    //MARK: - 点击规格选择
    func zxDrugCommonInfoSpecSelectAction() {
        let specsVC = ZXDrugSpecsSelectViewController()
        specsVC.type = .none
        specsVC.buyCount = (self.drugCommonInfo.selectedSpec?.zx_count) ?? 1
        specsVC.delegate = self
        specsVC.drugDetailInfo = self.goodsDetailModel
        specsVC.selectedIndex = self.specIndex
        self.present(specsVC, animated: true, completion: nil)
    }
}
//MARK: - 规格选择完成
extension ZXDrugDetailInfoViewController: ZXDrugSpecsSelectDelegate {
    func zxDrugSpecCountChange(_ count: Int) {
        self.selectedSpec?.zx_count = count
        
        self.drugCommonInfo.selectedSpec = self.selectedSpec//
    }
    
    func zxDrugSpecSelctAt(index: Int, model: ZXDrugSpecModel) {
        self.selectedSpec = model
        if model.isColl {
            self.btnMark.isSelected = true
        } else {
            self.btnMark.isSelected = false
        }
        
        self.drugCommonInfo.selectedSpec = self.selectedSpec//

    }
    
    func zxDrugSpecBalanceDone(model: ZXBalanceModel?) {
        let balanceVC = ZXBalanceViewController()
        balanceVC.balanceModel = model
        self.navigationController?.pushViewController(balanceVC, animated: true)
    }
}

//MARK: - ZXSegment
extension ZXDrugDetailInfoViewController: ZXSegmentDelegate, ZXSegmentDataSource {
    
    func zxsegment(_ segment: ZXSegment, didSelectAt index: Int) {
        let offset:CFloat = CFloat(index) * CFloat(ZXBOUNDS_WIDTH)
        self.mainScrollView.setContentOffset(CGPoint.init(x: CGFloat(offset), y: 0), animated: true)
    }
    
    func numberOfTitles(in segment: ZXSegment) -> Int {
        return 3
    }
    
    func zxsegment(_ segment: ZXSegment, titleOf index: Int) -> String {
        switch index {
        case 0:
            return "药品"
        case 1:
            return "说明书"
        case 2:
            return "药店详情"
        default:
            return ""
        }
    }
}
