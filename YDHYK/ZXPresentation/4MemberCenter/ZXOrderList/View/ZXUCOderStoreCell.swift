//
//  ZXUCOderStoreCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/7.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 订单列表-店铺信息
class ZXUCOderStoreCell: UITableViewCell {

    static let height: CGFloat = 67
    
    @IBOutlet weak var imgStoreIcon: ZXUIImageView!
    @IBOutlet weak var lbStoreName: ZXUILabel!
    @IBOutlet weak var lbOrderStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbOrderStatus.font = UIFont.zx_titleFont
        self.lbOrderStatus.textColor = UIColor.zx_tintColor
    }

    func reloadData(model: ZXUCOrderDetailModel?) {
        imgStoreIcon.image = nil
        lbStoreName.text = nil
        lbOrderStatus.text = nil
        if let model = model {
            imgStoreIcon.kf.setImage(with: URL.init(string: model.headPortraitStr))
            lbStoreName.text = model.drugstoreName
            lbOrderStatus.text = model.zx_status.description()
        }
    }
    
}
