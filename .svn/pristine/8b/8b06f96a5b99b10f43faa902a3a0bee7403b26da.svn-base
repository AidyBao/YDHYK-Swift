//
//  ZXDrugStoreInfoViewController.swift
//  YDHYK
//
//  Created by screson on 2017/10/16.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
import CoreLocation

/// 店铺详情
class ZXDrugStoreInfoViewController: ZXSTUIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var detailInfo: ZXStoreDetailModel? {
        didSet {
            if let m = detailInfo {
                if let url = URL.init(string: ZXAPI.file(address: m.headPortrait)) {
                    self.headerImage.kf.setImage(with: url, placeholder : UIImage.Default.empty)
                } else {
                    self.headerImage.image = UIImage.Default.empty
                }
                self.tblList.tableHeaderView = self.headerImage
            }
            self.tblList.reloadData()
        }
    }
    var headerImage: UIImageView!
    @IBOutlet weak var tblList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.headerImage = UIImageView.init(frame: CGRect(x: 0, y: 0, width: ZXBOUNDS_WIDTH, height: 280))
        self.headerImage.contentMode = .scaleAspectFill
        self.headerImage.clipsToBounds = true
        self.tblList.backgroundColor = UIColor.zx_subTintColor
        self.tblList.register(UINib.init(nibName: ZXStoreHeaderCell.NibName, bundle: nil), forCellReuseIdentifier: ZXStoreHeaderCell.reuseIdentifier)
        self.tblList.register(UINib.init(nibName: ZXStoreContactInfoCell.NibName, bundle: nil), forCellReuseIdentifier: ZXStoreContactInfoCell.reuseIdentifier)
        self.tblList.register(UINib.init(nibName: ZXStoreIntroductionCell.NibName, bundle: nil), forCellReuseIdentifier: ZXStoreIntroductionCell.reuseIdentifier)
        self.tblList.estimatedRowHeight = 80
        
        self.tblList.zx_addHeaderRefresh(showGif: true, target: self, action: #selector(zx_refresh))
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAction), name: NSNotification.Name.init("StoreUIUpdate"), object: nil)
    }
    
    @objc func reloadAction() {
        self.tblList.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !onceLoad {
            self.onceLoad = true
            self.tblList.reloadData()
        }
    }
    
    override func zx_refresh() {
        ZXDrugStoreViewModel.storeDetail(storeId: ZXStoreParams.storeId) { (s, c, error, model) in
            self.tblList.mj_header.endRefreshing()
            if s {
                ZXStoreParams.storeInfo = model
                self.detailInfo = model
                self.tblList.reloadData()
            } else {
                ZXHUD.showFailure(in: self.view, text: "获取店铺详情失败", delay: ZX.HUDDelay)
            }
            ZXDrugDetailInfoViewController.postDrugUIUpdateNotice()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init("StoreUIUpdate"), object: nil)
    }
    
    //MARK: - TBL
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            //MARK: - 地图
            if indexPath.row == 1 {
                if let model = self.detailInfo {
                    let mapVC = ZXSoreMapInfoViewController()
                    mapVC.location = CLLocationCoordinate2D.init(latitude: model.latitude, longitude: model.longitude)
                    mapVC.storeName = model.name
                    mapVC.address = model.address
                    self.navigationController?.pushViewController(mapVC, animated: true)
                } else {
                    ZXHUD.showFailure(in: self.view, text: "位置信息不存在", delay: ZX.HUDDelay)
                }
                
            } else if indexPath.row == 3 {
                //MARK: - 电话
                if let model = self.detailInfo,model.tel.count > 0 {
                    ZXCommonUtils.call(model.tel, failed: { (str) in
                        ZXHUD.showFailure(in: self.view, text: str, delay: ZX.HUDDelay)

                    })
                } else {
                    ZXHUD.showFailure(in: self.view, text: "暂无相关联系电话", delay: ZX.HUDDelay)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXStoreIntroductionCell.reuseIdentifier, for: indexPath) as! ZXStoreIntroductionCell
            cell.reloadData(model: self.detailInfo)
            return cell
        } else if indexPath.section == 0,indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXStoreHeaderCell.reuseIdentifier, for: indexPath) as! ZXStoreHeaderCell
            cell.reloadData(model: self.detailInfo)

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXStoreContactInfoCell.reuseIdentifier, for: indexPath) as! ZXStoreContactInfoCell
            cell.imgArrow.isHidden = false
            if let model = self.detailInfo {
                switch indexPath.row {
                    case 1:
                        cell.lbTextInfo.text = "地址：\(model.address)"
                        cell.imgIcon.image = #imageLiteral(resourceName: "store-address")
                    case 2:
                        cell.lbTextInfo.text = "营业时间：\(model.zx_businessHours)"
                        cell.imgArrow.isHidden = true
                        cell.imgIcon.image = #imageLiteral(resourceName: "store-time")
                    case 3:
                        cell.lbTextInfo.text = "联系电话：\(model.tel)"
                        cell.imgIcon.image = #imageLiteral(resourceName: "store-contact")
                    default:
                        cell.lbTextInfo.text = ""
                        cell.imgArrow.isHidden = true
                        cell.imgIcon.image = nil
                }
            } else {
                cell.imgIcon.image = nil
                cell.lbTextInfo.text = ""
            }
            
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.detailInfo != nil {
            if section == 0 {
                return 4
            }
            return 1
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0:
                if indexPath.row == 0 {
                    return UITableViewAutomaticDimension
                }
            case 1:
                return UITableViewAutomaticDimension
            default:
                break
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 5
    }
    
}
