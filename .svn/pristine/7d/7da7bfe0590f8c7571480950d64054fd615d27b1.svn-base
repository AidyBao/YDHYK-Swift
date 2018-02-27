//
//  ZXStoreDetailView.swift
//  YDHYK
//
//  Created by 120v on 2017/11/16.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

protocol ZXStoreDetailViewDelegate: NSObjectProtocol {
    func didZXStoreDetailView(_ sender: UIButton,_ model: ZXSearchModel)
}

class ZXStoreDetailView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var delegate:ZXStoreDetailViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.zx_subTintColor
        self.addSubview(self.collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.zx_subTintColor
        self.addSubview(self.collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func loadData(_ arr: NSArray) {
        self.dataArray = NSMutableArray.init(array: arr)
        self.collectionView.reloadData()
    }
    
    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: ZXBOUNDS_WIDTH, height: 133)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZXStoreCell.ZXStoreCellID, for: indexPath) as! ZXStoreCell
        cell.delegate = self
        if self.dataArray.count != 0 {
            let model: ZXSearchModel = self.dataArray.object(at: indexPath.row) as! ZXSearchModel
            cell.loadData(model)
        }
        return cell
    }
    

    //MARK: Lazy
    lazy var collectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        let collView: UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: ZXBOUNDS_WIDTH, height: 133), collectionViewLayout: flowLayout)
        collView.backgroundColor = UIColor.zx_subTintColor
        collView.showsVerticalScrollIndicator = false
        collView.delegate = self
        collView.dataSource = self
        collView.register(UINib.init(nibName: String.init(describing: ZXStoreCell.self), bundle: nil), forCellWithReuseIdentifier: ZXStoreCell.ZXStoreCellID)
        return collView
    }()

    lazy var dataArray: NSMutableArray = {
        let arr: NSMutableArray = NSMutableArray.init(capacity: 2)
        return arr
    }()
}

extension ZXStoreDetailView: ZXStoreCellDelegate {
    func didZXStoreCell(_ sender: UIButton, _ model: ZXSearchModel) {
        if delegate != nil {
            delegate?.didZXStoreDetailView(sender, model)
        }
    }
}
