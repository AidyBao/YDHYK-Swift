//
//  ZXDiscoverVC+CollectionView.swift
//  YDHYK
//
//  Created by screson on 2017/11/3.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 发现页-大菜单
extension ZXDiscoverRootViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            ZXJoinLeadViewController.checkShow(completion: {
                let scanVC = ZXQRCodeScanViewController()
                self.navigationController?.pushViewController(scanVC, animated: true)
            })
        case 1:
            let memberQRCodeInfoVC = ZXMyQRCodeViewController()
            self.navigationController?.pushViewController(memberQRCodeInfoVC, animated: true)
        case 2:
            let smartToolVC = ZXSmartToolViewController()
            self.navigationController?.pushViewController(smartToolVC, animated: true)
        default:
            break
        }
    }
    //DataSource
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ccvTopMenu.dequeueReusableCell(withReuseIdentifier: ZXMenuCCVCell.reuseIdentifier, for: indexPath) as! ZXMenuCCVCell
        switch indexPath.row {
            case 0:
                cell.lbName.text = "加入会员"
                cell.imgIcon.image = #imageLiteral(resourceName: "btn-join")
            case 1:
                cell.lbName.text = "验证会员"
                cell.imgIcon.image = #imageLiteral(resourceName: "btn-Test")
            case 2:
                cell.lbName.text = "智能工具"
                cell.imgIcon.image = #imageLiteral(resourceName: "btn-tool")
            default:
                cell.lbName.text = ""
                cell.imgIcon.image = nil
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    //Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: floor(ZXBOUNDS_WIDTH / 3), height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}