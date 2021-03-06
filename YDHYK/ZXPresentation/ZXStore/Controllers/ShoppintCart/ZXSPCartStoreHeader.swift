//
//  ZXSPCartStoreHeader.swift
//  YDHYK
//
//  Created by screson on 2017/10/23.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

protocol ZXSPCartStoreHeaderDelegate: class {
    func zxSPCartStoreHeader(_ storeHeader: ZXSPCartStoreHeader,checked: Bool,selectAt storeModel: ZXStoreDetailModel?)
    func zxSPCartStoreHeader(_ storeHeader: ZXSPCartStoreHeader,selectAt storeModel: ZXStoreDetailModel?)
}

extension ZXSPCartStoreHeaderDelegate {
    func zxSPCartStoreHeader(_ storeHeader: ZXSPCartStoreHeader,checked: Bool,selectAt storeModel: ZXStoreDetailModel?) {}
    func zxSPCartStoreHeader(_ storeHeader: ZXSPCartStoreHeader,selectAt storeModel: ZXStoreDetailModel?) {}
}

/// 购物车 店铺Header
class ZXSPCartStoreHeader: UITableViewHeaderFooterView {
    
    weak var delegate: ZXSPCartStoreHeaderDelegate?
    
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var btnStoreTitle: UIButton!
    fileprivate var storeModel: ZXStoreDetailModel?
    @IBOutlet weak var lbFreightInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btnCheck.setImage(#imageLiteral(resourceName: "dk-checkbox-2"), for: .normal)
        self.btnCheck.setImage(#imageLiteral(resourceName: "dk-checkbox-1"), for: .selected)
        self.clipsToBounds = true
    }

    //MARK: - 选中
    @IBAction func checkAction(_ sender: UIButton) {
        self.btnCheck.isSelected = self.btnCheck.isSelected ? false : true
        self.storeModel?.zx_checked = self.btnCheck.isSelected
        delegate?.zxSPCartStoreHeader(self, checked: self.btnCheck.isSelected, selectAt: self.storeModel)
    }
    //MARK: - 标题->跳转店铺 去凑单->跳转店铺
    @IBAction func storeTitleAction(_ sender: UIButton) {
        delegate?.zxSPCartStoreHeader(self, selectAt: self.storeModel)
    }
    
    func reloadData(model: ZXStoreDetailModel?) {
        self.storeModel = model
        self.imgIcon.image = UIImage.Default.drug
        self.btnStoreTitle.setTitle("", for: .normal)
        self.lbFreightInfo.text = ""
        if let model = model {
            self.btnStoreTitle.setTitle(model.name, for: .normal)
            self.btnCheck.isSelected = model.zx_checked
            if let url = URL.init(string: ZXAPI.file(address: model.headPortrait) ) {
                self.imgIcon.kf.setImage(with: url, placeholder: UIImage.Default.drug)
            }
            if model.freeSndPrice > 0 {
                self.lbFreightInfo.text = "满\(model.freeSndPrice)元包邮"
            }
        }
    }
}
