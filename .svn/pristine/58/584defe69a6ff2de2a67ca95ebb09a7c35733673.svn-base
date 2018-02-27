//
//  ZXOrderMenuCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/6.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 订单类型Menu
class ZXOrderMenuCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    static let height:CGFloat = 84

    @IBOutlet weak var ccvList: UICollectionView!
    
    weak var delegate: ZXUserInfoMenuActionProtocol?
    var unReadMsgCountModel: ZXAllUnReadCountModel? {
        didSet {
            self.ccvList.reloadData()
        }
    }
    
    let imageNames = ["h_order_1","h_order_2","h_order_3","h_order_4","h_order_5"]
    let titleNames = ["待付款","待提货","待发货","待收货","已完成"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.ccvList.register(UINib.init(nibName: ZXOrderMenuCollectionViewCell.NibName, bundle: nil), forCellWithReuseIdentifier: ZXOrderMenuCollectionViewCell.reuseIdentifier)
        self.ccvList.delegate = self
        self.ccvList.dataSource = self
    }
    
    //MARK: - -
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.zxUserInfoMenuOrderMenuAction(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZXOrderMenuCollectionViewCell.reuseIdentifier, for: indexPath) as! ZXOrderMenuCollectionViewCell
        cell.reload(title: titleNames[indexPath.row], image: UIImage.init(named: imageNames[indexPath.row])!)
        cell.setUnReadMessageCount(0)
        if let model = self.unReadMsgCountModel {
            switch indexPath.row {
                case 0:
                    cell.setUnReadMessageCount(model.notPayNum)
                case 1:
                    cell.setUnReadMessageCount(model.notTakeNum)
                case 2:
                    cell.setUnReadMessageCount(model.notSendNum)
                case 3:
                    cell.setUnReadMessageCount(model.notReciveNum)
                default:
                    break
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: floor(ZXBOUNDS_WIDTH / 5), height: ZXOrderMenuCell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
