//
//  ZXUCOrderStatusWithProgress.swift
//  YDHYK
//
//  Created by screson on 2017/11/8.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 订单详情-订单状态抬头（有进度条）
class ZXUCOrderStatusWithProgressCell: UITableViewCell {

    static let height: CGFloat = 144
    
    @IBOutlet weak var statusBackView: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbStatusText: UILabel!
    @IBOutlet weak var lbDetailText: UILabel!
    
    @IBOutlet weak var statusProgress: UIProgressView!
    @IBOutlet weak var imgStatus1: ZXUIImageView!
    @IBOutlet weak var imgStatus2: ZXUIImageView!
    @IBOutlet weak var imgStatus3: ZXUIImageView!
    @IBOutlet weak var lbStatus1: UILabel!
    @IBOutlet weak var lbStatus2: UILabel!
    @IBOutlet weak var lbStatus3: UILabel!
    
    
    var statusColorlayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.contentsScale = UIScreen.main.scale
        layer.frame = CGRect(x: 0, y: 0, width: ZXBOUNDS_WIDTH, height: ZXUCOrderStatusCell.height)
        layer.colors = [UIColor.zx_colorRGB(60, 168, 240, 1).cgColor,UIColor.zx_colorRGB(59, 136, 238, 1).cgColor]
        return layer
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbStatusText.font = UIFont.zx_titleFont
        self.lbDetailText.font  = UIFont.zx_titleFont(12)
        
        //
        let color = UIColor.zx_colorRGB(187, 191, 196, 1.0)
        self.statusProgress.trackTintColor = color
        self.statusProgress.progressTintColor = UIColor.zx_tintColor
        self.lbStatus1.font  = UIFont.zx_titleFont(13)
        self.lbStatus1.highlightedTextColor = UIColor.zx_tintColor
        self.lbStatus1.textColor = color
        self.lbStatus2.font  = UIFont.zx_titleFont(13)
        self.lbStatus2.highlightedTextColor = UIColor.zx_tintColor
        self.lbStatus2.textColor = color
        self.lbStatus3.font  = UIFont.zx_titleFont(13)
        self.lbStatus3.highlightedTextColor = UIColor.zx_tintColor
        self.lbStatus3.textColor = color
        
        self.statusBackView.layer.insertSublayer(self.statusColorlayer, at: 0)
    }
    
    func reloadData(model: ZXUCOrderDetailModel?) {
        self.lbStatusText.text = ""
        self.lbDetailText.text = ""
        
        self.lbStatus1.text = "下单成功"
        self.lbStatus2.text = "已发货"
        self.lbStatus3.text = "确认收货"
        
        if let model = model {
            switch model.zx_status {
                //case .waitPay://待付款 statusCell中呈现
                //case .canceled://已取消 statusCell中呈现
                //case .refunding://退款中 statusCell中呈现
                case .preparing://待备货 （下单完成）
                    self.lbStatusText.text = "订单进行中"
                    self.lbDetailText.text = "下单成功,等待店员备货"
                case .waitTake://待提货
                    self.lbStatusText.text = "订单进行中"
                    self.lbDetailText.text = "店员已备货,使用提货码取走您的订单药品"
                case .waitDispatch://待发货
                    self.lbStatusText.text = "订单进行中"
                    self.lbDetailText.text = "下单成功,请等待店员发货"
                case .dispatched://待收货
                    self.lbStatusText.text = "订单进行中"
                    self.lbDetailText.text = "店员已发货,请等待收货"
                case .finished://已完成
                    self.lbStatusText.text = "订单已完成"
                    self.lbDetailText.text = "感谢您的光临"
                default:
                    break
            }
            self.reloadProgress(status: model.zx_status,type: model.zx_receiveType)
        }
    }
    
    fileprivate func reloadProgress(status: ZXUCOrderStatus,type: ZXUCOrderReceivingType) {
        lbStatus1.text = "下单成功"
        lbStatus2.text = "已发货"
        lbStatus3.text = "确认收货"
        switch status {
            //case .waitPay://待付款 statusCell中呈现
            //case .canceled://已取消 statusCell中呈现
            //case .refunding://退款中 statusCell中呈现
            case .preparing://待备货 （下单完成）
                imgIcon.image = #imageLiteral(resourceName: "hOrder_waitTake_icon")
                imgStatus1.isHighlighted = true
                imgStatus2.isHighlighted = false
                imgStatus3.isHighlighted = false

                lbStatus1.isHighlighted = true
                lbStatus2.isHighlighted = false
                lbStatus3.isHighlighted = false
                
                if type == .selfTake {
                    lbStatus2.text = "店员备货"
                    lbStatus3.text = "到店提货"
                }
                statusProgress.progress = 0.25
            case .waitTake://待提货
                imgIcon.image = #imageLiteral(resourceName: "hOrder_waitTake_icon")
                imgStatus1.isHighlighted = true
                imgStatus2.isHighlighted = true
                imgStatus3.isHighlighted = false
                
                lbStatus1.isHighlighted = true
                lbStatus2.isHighlighted = true
                lbStatus3.isHighlighted = false
                
                lbStatus2.text = "店员备货"
                lbStatus3.text = "到店提货"

                statusProgress.progress = 0.75
            case .waitDispatch://待发货
                imgIcon.image = #imageLiteral(resourceName: "hOrder_waitDispatch_icon")
                imgStatus1.isHighlighted = true
                imgStatus2.isHighlighted = false
                imgStatus3.isHighlighted = false
                
                lbStatus1.isHighlighted = true
                lbStatus2.isHighlighted = false
                lbStatus3.isHighlighted = false
                
                statusProgress.progress = 0.25
            case .dispatched://待收货
                imgIcon.image = #imageLiteral(resourceName: "hOrder_waitSign_icon")
                imgStatus1.isHighlighted = true
                imgStatus2.isHighlighted = true
                imgStatus3.isHighlighted = false
                
                lbStatus1.isHighlighted = true
                lbStatus2.isHighlighted = true
                lbStatus3.isHighlighted = false
                
                statusProgress.progress = 0.75
            case .dispatched://已完成
                imgIcon.image = #imageLiteral(resourceName: "hOrder_done_icon")
                imgStatus1.isHighlighted = true
                imgStatus2.isHighlighted = true
                imgStatus3.isHighlighted = true
                
                lbStatus1.isHighlighted = true
                lbStatus2.isHighlighted = true
                lbStatus3.isHighlighted = true
                
                if type == .selfTake {
                    lbStatus2.text = "店员备货"
                    lbStatus3.text = "到店提货"
                }
                statusProgress.progress = 1.0
            default:
                break
        }
    }
    
}
