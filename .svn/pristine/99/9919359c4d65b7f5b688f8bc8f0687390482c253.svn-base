//
//  ZXUCOrderDrugCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/7.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 订单药品信息
class ZXUCOrderDrugCell: UITableViewCell {

    static let height: CGFloat = 70
    
    @IBOutlet weak var imgDrugIcon: UIImageView!
    @IBOutlet weak var lbDrugName: ZXUILabel!
    @IBOutlet weak var lbDrugSpec: ZXUILabel!
    @IBOutlet weak var lbBuyNum: ZXUILabel!
    @IBOutlet weak var lbPrice: ZXUILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.clear()
    }
    
    fileprivate func clear() {
        imgDrugIcon.image = nil
        lbDrugName.text = nil
        lbDrugSpec.text = nil
        lbBuyNum.text = nil
        lbPrice.text = nil
    }
    
    func reloadData(model: ZXUCOrderDrugModel?) {
        self.clear()
        if let model = model {
            imgDrugIcon.kf.setImage(with: URL.init(string: model.attachFilesStr))
            lbDrugName.text = model.drugName
            lbDrugSpec.text = model.packingSpec
            lbPrice.text = model.priceStr.zx_priceString()
            lbBuyNum.text = "x\(model.num)"
        }
    }
}
