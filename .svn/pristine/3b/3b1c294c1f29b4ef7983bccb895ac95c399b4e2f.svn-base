//
//  ZXUCOrderStatus.swift
//  YDHYK
//
//  Created by screson on 2017/11/8.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 订单详情-订单状态抬头（无进度条）
class ZXUCOrderStatusCell: UITableViewCell {

    static let height: CGFloat = 72
    
    @IBOutlet weak var backContentView: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbStatustext: UILabel!
    @IBOutlet weak var lbDetailInfo: UILabel!
    @IBOutlet weak var lbCanceledText: UILabel!
    
    var statusColorlayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.contentsScale = UIScreen.main.scale
        layer.frame = CGRect(x: 0, y: 0, width: ZXBOUNDS_WIDTH, height: ZXUCOrderStatusCell.height)
        return layer
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbStatustext.font = UIFont.zx_titleFont
        self.lbCanceledText.font = UIFont.zx_titleFont
        self.lbDetailInfo.font  = UIFont.zx_titleFont(12)
        self.backContentView.layer.insertSublayer(self.statusColorlayer, at: 0)
    }

    func reloadData(model: ZXUCOrderDetailModel?) {
        self.lbCanceledText.isHidden = true
        self.lbStatustext.isHidden = true
        self.lbDetailInfo.isHidden = true
        
        self.statusColorlayer.colors = [UIColor.zx_colorRGB(60, 168, 240, 1).cgColor,UIColor.zx_colorRGB(59, 136, 238, 1).cgColor]
        if let model = model {
            switch model.zx_status {
                case .waitPay://待付款
                    self.lbStatustext.isHidden = false
                    self.lbDetailInfo.isHidden = false
                    imgIcon.image = #imageLiteral(resourceName: "hOrder_waitPay_icon")
                    self.lbStatustext.text = "订单未付款"
                    self.lbDetailInfo.text = ""
                case .waitTake,.waitDispatch,.dispatched,.preparing,.finished://有进度条 在ProgressCell中呈现
                    self.lbStatustext.text = ""
                    self.lbDetailInfo.text = ""
                case .canceled://已取消
                    self.lbCanceledText.isHidden = false
                    imgIcon.image = #imageLiteral(resourceName: "hOrder_done_icon")
                    self.lbStatustext.text = "订单已取消"
                case .refunding://退款中
                    self.lbCanceledText.isHidden = false
                    imgIcon.image = #imageLiteral(resourceName: "hOrder_done_icon")
                    self.lbStatustext.text = "订单退款中"
                default:
                    break
            }
            if model.zx_status == .waitPay {
                self.statusColorlayer.colors = [UIColor.zx_colorRGB(248, 160, 118, 1).cgColor,UIColor.zx_colorRGB(247, 140, 118, 1).cgColor]
            }
        }
    }
    
}
