//
//  ZXNearbyStoreViewController+Table.swift
//  YDHYK
//
//  Created by 120v on 2017/11/20.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

extension ZXNearbyStoreViewController: UITableViewDelegate {
    
}


extension ZXNearbyStoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataModelArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 143.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ZXStoreListCell = tableView.dequeueReusableCell(withIdentifier: ZXStoreListCell.ZXStoreListCellID, for: indexPath) as! ZXStoreListCell
        cell.delegate = self
        if self.dataModelArray.count != 0 {
            let model: ZXSearchModel = self.dataModelArray.object(at: indexPath.row) as! ZXSearchModel
            cell.loadData(model)
        }
        return cell
    }
}

extension ZXNearbyStoreViewController: ZXStoreListCellDelegate {
    func didZXStoreListCell(_ sender: UIButton, _ model: ZXSearchModel) {
        switch sender.tag {
        case ZXStoreListCell.BtnTag.nav://定位
            if Float(model.latitude) != 0.0 , Float(model.longitude) != 0.0 {
                
                let vcArr: Array<Any> = (self.navigationController?.viewControllers)!
                var mapVC: ZXNearbyRootViewController?
                for (_,vc) in vcArr.enumerated() {
                    if ((vc as? ZXNearbyRootViewController) != nil) {
                        mapVC = (vc as? ZXNearbyRootViewController)!
                    }
                }
                mapVC?.isListVCLocationClick = true
                self.navigationController?.popToViewController(mapVC!, animated: true)
                var mArr: Array<ZXSearchModel> = Array.init()
                mArr.append(model)
                mapVC?.modelArray = mArr
                mapVC?.loadDataForDetailView(mArr)
            }else{
                ZXHUD.showFailure(in: self.view, text: "定位失败", delay: ZX.HUDDelay)
                return
            }
        case ZXStoreListCell.BtnTag.tel://电话
            if model.tel.count != 0 {
                ZXCommonUtils.call(model.tel, failed: { (errMsg) in
                    ZXAlertUtils.showAlert(wihtTitle:"提示" , message: "该设备不支持拨打电话功能", buttonText: "知道了", action: nil)
                })
            }else{
                ZXHUD.showFailure(in: self.view, text: "无相关联系方式", delay: ZX.HUDDelay)
            }
        case ZXStoreListCell.BtnTag.join://加入会员
            if model.isMember == 0 {
                ZXJoinLeadViewController.checkShow(completion: {
                    self.navigationController?.pushViewController(ZXQRCodeScanViewController(), animated: true)
                })
            }
        case ZXStoreListCell.BtnTag.buy://购药
            if model.isMember == 1 {
                let storeVC = ZXStoreRootViewController.configVC(storeId: "\(model.storeId)", memberId: ZXUser.user.memberId, token: ZXUser.user.userToken)
                self.navigationController?.pushViewController(storeVC, animated: true)
            }
        default:
            break
        }
    }
}
