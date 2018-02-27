//
//  ZXDurgCommonInfoViewController.swift
//  YDHYK
//
//  Created by screson on 2017/10/16.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
import ZXAutoScrollView

protocol ZXDrugCommonInfoDelegate: class {
    func zxDrugCommonInfoReloadGoodsDetail(_ detail: ZXDrugDetailModel?)
    func zxDrugCommonInfoSpecSelectAction()
}

/// 商品基础详情
class ZXDurgCommonInfoViewController: ZXSTUIViewController {
    
    weak var delegate: ZXDrugCommonInfoDelegate?
    
    var zxScrollView: ZXAutoScrollView!
    var shortModel: ZXDrugModel?
    var goodsDetailModel: ZXDrugDetailModel?
    
    var relateGoodsList: Array<ZXDrugModel>? {
        didSet {
            self.tblGoodsInfo.reloadData()
        }
    }
    
    var selectedSpec:ZXDrugSpecModel? {
        didSet {
            self.tblGoodsInfo.reloadData()
//            if self.goodsDetailModel != nil {
//                self.tblGoodsInfo.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .none)
//            }
        }
    }
    
    
    @IBOutlet weak var tblGoodsInfo: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.zx_subTintColor
        
        zxScrollView = ZXAutoScrollView.init(frame: CGRect(x: 0, y: 0, width: ZXBOUNDS_WIDTH, height: 280))
        zxScrollView.backgroundColor = UIColor.white
        zxScrollView.autoFlip = false
        zxScrollView.pageControl.currentPageIndicatorTintColor = UIColor.zx_textColorTitle
        zxScrollView.pageControl.pageIndicatorTintColor = UIColor.zx_textColorMark
        zxScrollView.dataSource = self
        
        self.tblGoodsInfo.backgroundColor = UIColor.clear
        self.tblGoodsInfo.tableHeaderView = zxScrollView
        self.tblGoodsInfo.register(UINib.init(nibName: ZXSingleTitleCell.NibName, bundle: nil), forCellReuseIdentifier: ZXSingleTitleCell.reuseIdentifier)
        self.tblGoodsInfo.register(UINib.init(nibName: ZXDrugInfoTableViewCell.NibName, bundle: nil), forCellReuseIdentifier: ZXDrugInfoTableViewCell.reuseIdentifier)
        self.tblGoodsInfo.register(UINib.init(nibName: ZXSpecSelectCell.NibName, bundle: nil), forCellReuseIdentifier: ZXSpecSelectCell.reuseIdentifier)
        self.tblGoodsInfo.register(UINib.init(nibName: ZXRelateGoodsListCell.NibName, bundle: nil), forCellReuseIdentifier: ZXRelateGoodsListCell.reuseIdentifier)
        self.tblGoodsInfo.estimatedRowHeight = 80
        self.tblGoodsInfo.zx_addHeaderRefresh(showGif: true, target: self, action: #selector(zx_refresh))
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAction), name: NSNotification.Name.init("DrugUIUpdate"), object: nil)
        
    }
    
    override func zx_refresh() {
        self.fetchDrugDetail(showHUD: false, finished: nil)
    }
    
    @objc func reloadAction() {
        if self.goodsDetailModel != nil {
            self.tblGoodsInfo.reloadData()
            self.zxScrollView.reloadData()
        }
        delegate?.zxDrugCommonInfoReloadGoodsDetail(self.goodsDetailModel)
    }
    
    
    func fetchDrugDetail(showHUD:Bool,finished:((_ drugInfo:ZXDrugDetailModel?,_ storeInfo:ZXStoreDetailModel?) -> Void)?) {
        if let sModel = self.shortModel {
            if showHUD {
                ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
            }
            ZXDrugViewModel.durgDetailInfo(sModel.baseDrugId, storeId: sModel.drugstoreId, approvalNum: sModel.approvalNumber, completion: {  [unowned self] (c, s, drug,store, errorMsg) in
                ZXHUD.hide(for: self.view, animated: true)
                self.tblGoodsInfo.mj_header.endRefreshing()
                if s {
                    if let store = store {
                        self.goodsDetailModel = drug
                        ZXStoreParams.storeInfo = store
                        self.reloadAction()
                        finished?(drug,store)
                    } else {
                        ZXHUD.showFailure(in: self.view, text: "药品信息为空", delay: ZX.HUDDelay)
                    }
                } else {
                    if c != ZXAPI_LOGIN_INVALID {
                        ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                    }
                }
                ZXDrugDetailInfoViewController.postStoreUIUpdateNotice()
            })
            
            //相关推荐
            ZXDrugViewModel.randomList(storeId: sModel.drugstoreId, completion: { (s, c, errorMsg, list) in
                if s {
                    self.relateGoodsList = list
                }
            })
        } else {
            ZXHUD.showFailure(in: self.view, text: "药品信息为空", delay: ZX.HUDDelay)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init("DrugUIUpdate"), object: nil)
    }
}

//MARK: - Tableview
extension ZXDurgCommonInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 { //服务承诺
            DispatchQueue.main.async {
                let promiseList = ZXPromiseLIstViewController()
                self.present(promiseList, animated: true, completion: nil)
            }
        } else if indexPath.section == 2 { //规格选择
            delegate?.zxDrugCommonInfoSpecSelectAction()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0://名称 规格 药效 价格
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXDrugInfoTableViewCell.reuseIdentifier, for: indexPath) as! ZXDrugInfoTableViewCell
            cell.reloadData(self.goodsDetailModel, selectedSpec: self.selectedSpec)
            return cell
        case 1:// 正品保障 货到付款 小标签
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXSpecSelectCell.reuseIdentifier, for: indexPath) as! ZXSpecSelectCell
            cell.lbRightText.text = ""
            cell.lbLeftText.textColor = UIColor.zx_textColorTitle
            cell.lbLeftText.font = UIFont.zx_iconFont(UIFont.zx_bodyFontSize)
            cell.lbLeftText.attributedText = ZXStoreParams.storeInfo?.zx_promiseAttributeString
            return cell
        case 2:// 规格选择
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXSpecSelectCell.reuseIdentifier, for: indexPath) as! ZXSpecSelectCell
            cell.lbLeftText.text = "已选"
            if let spec = self.selectedSpec {
                cell.lbRightText.text = spec.name + " 数量:\(spec.zx_count)"
            } else {
                cell.lbRightText.text = ""
            }
            
            return cell
        case 3:// 相关药品推荐
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ZXSingleTitleCell.reuseIdentifier, for: indexPath) as! ZXSingleTitleCell
                cell.lbText.text = "买过该药的人还买了"
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ZXRelateGoodsListCell.reuseIdentifier, for: indexPath) as! ZXRelateGoodsListCell
                cell.delegate = self
                if let list = self.relateGoodsList {
                    cell.drugList = list
                } else {
                    cell.drugList = []
                }
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXSingleTitleCell.reuseIdentifier, for: indexPath) as! ZXSingleTitleCell
            cell.lbText.text = ""
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0:
                return UITableViewAutomaticDimension
            case 3:
                if indexPath.row == 1 {
                    return ZXRelateGoodsListCell.cellHeight
                }
            default:
                break
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.goodsDetailModel != nil {
            switch section {
                case 0://名称 规格 药效 价格
                    return 1
                case 1:
                    if let store = ZXStoreParams.storeInfo, !store.promise.isEmpty {
                        return 1
                    }
                case 2:
                    return 1
                case 3:
                    if self.relateGoodsList != nil {
                        return 2
                    }
                default:
                    return 0
            }
        }
        return 0
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.goodsDetailModel != nil {
            switch section {
                case 1:
                    return 10
                case 2:
                    return 10
                case 3:
                    if self.relateGoodsList != nil {
                        return 5
                    }
            default:
                break
            }
        }
        
        return CGFloat.leastNormalMagnitude
    }
}

extension ZXDurgCommonInfoViewController: ZXStoreActiveCellDelegate {
    func zxStoreActiveCell(_ cell: UITableViewCell, goodsSelectAt model: ZXDrugModel) {
        let detail = ZXDrugDetailInfoViewController()
        detail.goodsShortModel = model
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
//MARK: - ZXAutoScrollView
extension ZXDurgCommonInfoViewController: ZXAutoScrollViewDataSource {
    
    func zxAutoScrollView(_ scrollView: ZXAutoScrollView, pageAt index: Int) -> UIView {
        let imageView = UIImageView.init()
        imageView.contentMode = .scaleAspectFit
        if let model = self.goodsDetailModel,let url = URL.init(string: ZXAPI.file(address: model.attachFilesStrs[index])) {
            imageView.kf.setImage(with: url, placeholder: UIImage.Default.empty)
        }
        return imageView
    }
    
    func numberofPages(_ inScrollView: ZXAutoScrollView) -> Int {
        if let model = self.goodsDetailModel {
            return model.attachFilesStrs.count
        }
        return 0
    }
}
