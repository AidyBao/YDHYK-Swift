//
//  ZXToolsMenuCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/6.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 我的工具 Menu
class ZXToolsMenuCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    static let height: CGFloat = 252
    
    weak var delegate: ZXUserInfoMenuActionProtocol?
    var unreadMsgCountModel: ZXAllUnReadCountModel? {
        didSet {
            self.ccvList.reloadData()
        }
    }
    
    let imageNames = ["h_tool_yytx-blue","h_tool_hyd","h_tool_scyp","h_tool_cf","h_tool_yy","h_tool_xjq"]
    let titleNames = ["用药提醒","化验单分析","收藏","处方","预约","现金券"]
    @IBOutlet weak var ccvList: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.ccvList.register(UINib.init(nibName: ZXOrderMenuCollectionViewCell.NibName, bundle: nil), forCellWithReuseIdentifier: ZXOrderMenuCollectionViewCell.reuseIdentifier)
        self.ccvList.delegate = self
        self.ccvList.dataSource = self
        
        let hLine = UIView.init(frame: CGRect(x: 0, y: 126, width: ZX_BOUNDS_WIDTH, height: 0.5))
        hLine.backgroundColor = UIColor.zx_borderColor
        self.ccvList.addSubview(hLine)

        let vLine1 = UIView.init(frame: CGRect(x: ZX_BOUNDS_WIDTH / 3 - 0.5, y: 0, width: 0.5, height: ZXToolsMenuCell.height))
        vLine1.backgroundColor = UIColor.zx_borderColor
        self.ccvList.addSubview(vLine1)
        
        let vLine2 = UIView.init(frame: CGRect(x: ZX_BOUNDS_WIDTH / 3 * 2 - 0.5, y: 0, width: 0.5, height: ZXToolsMenuCell.height))
        vLine2.backgroundColor = UIColor.zx_borderColor
        self.ccvList.addSubview(vLine2)
    }
    
    //MARK: - -
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.zxUserInfoMenuToolsMenuAction(at: indexPath.section * 3 + indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZXOrderMenuCollectionViewCell.reuseIdentifier, for: indexPath) as! ZXOrderMenuCollectionViewCell
        let index = indexPath.section * 3 + indexPath.row;
        cell.reload(title: titleNames[index], image: UIImage.init(named: imageNames[index])!)
         cell.setUnReadMessageCount(0)
        if index == 5,let model = self.unreadMsgCountModel { ////现金券
            cell.setUnReadMessageCount(model.couponUnRead)
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: floor((ZX_BOUNDS_WIDTH - 2) / 3.0), height: (ZXToolsMenuCell.height - 2) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
