//
//  ZXUCOrderControlFooterCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/7.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 订单 总价格+操作
class ZXUCOrderControlFooterCell: UITableViewCell {

    static let height: CGFloat = 81
    
    weak var delegate: ZXUCOrderControlActionDelegate?

    @IBOutlet weak var lbTotalPriceInfo: UILabel!
    @IBOutlet weak var btnControl1: UIButton!
    @IBOutlet weak var btnControl2: UIButton!
    @IBOutlet weak var control1ButtonWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbTotalPriceInfo.font = UIFont.zx_bodyFont(13)
        self.lbTotalPriceInfo.textColor = UIColor.zx_textColorBody
        
        btnControl1.layer.cornerRadius = 5
        btnControl1.layer.masksToBounds = true
        btnControl1.layer.borderWidth = 1.0
        btnControl1.titleLabel?.font = UIFont.zx_titleFont(14)
        btnControl1.addTarget(self, action: #selector(controlButton1Action), for: .touchUpInside)
        
        btnControl2.layer.cornerRadius = 5
        btnControl2.layer.masksToBounds = true
        btnControl2.layer.borderWidth = 1.0
        btnControl2.titleLabel?.font = UIFont.zx_titleFont(14)
        btnControl2.addTarget(self, action: #selector(controlButton2Action), for: .touchUpInside)
        self.lbTotalPriceInfo.text = nil
        self.btnControl1.isHidden = true
        self.btnControl2.isHidden = true
    }
    
    @objc func controlButton1Action() {
        var controlType: ZXOrderControlType = .none
        switch orderStatus {
            case .waitPay:  //待付款 (Control1:立即付款)
                controlType = .toPay
            case .waitTake: //待提货 (Control1:查看提货码)
                controlType = .reviewCode
            case .waitDispatch: //待发货 (Control1:查看提货码)
                controlType = .reviewCode
            case .dispatched: //待收货 (Control1: 查看提货码)
                controlType = .reviewCode
            case .finished: //已完成 (Control1: 删除订单)
                controlType = .delete
            case .canceled: //已取消 (Control1: 删除订单)
                controlType = .delete
            case .refunding: //退款中 (Control1: 无操作)
                controlType = .none
            case .preparing: //待备货 (Control1: 取消订单)
                controlType = .cancel
            default:
                break
        }
        delegate?.zxUCOrderControlerAction(with: controlType, cell: self)
    }
    
    @objc func controlButton2Action() {
        var controlType: ZXOrderControlType = .none
        switch orderStatus {
            case .waitPay:  //待付款 (Control2:取消订单)
                controlType = .cancel
            case .waitTake: //待提货 (Control2:取消订单)
                controlType = .cancel
            case .waitDispatch: //待发货 (Control2:取消订单)
                controlType = .cancel
            case .dispatched: //待收货 (Control2: 确认收货)
                controlType = .confirmSign
            case .finished: //已完成 (Control2: 无操作)
                controlType = .none
            case .canceled: //已取消 (Control2: 无操作)
                controlType = .none
            case .refunding: //退款中 (Control1: 无操作)
                controlType = .none
            case .preparing: //待备货 (Control2: 无操作)
                controlType = .none
            default:
                break
        }
        delegate?.zxUCOrderControlerAction(with: controlType, cell: self)
    }
    fileprivate var orderStatus: ZXUCOrderStatus = .invalid
    
    func reloadData(model: ZXUCOrderDetailModel?) {
        self.lbTotalPriceInfo.text = nil
        self.btnControl1.isHidden = true
        self.btnControl2.isHidden = true
        if let model = model {
            self.lbTotalPriceInfo.attributedText = model.zx_totalInfoAttributeStr
            self.reloadButton(with: model.zx_status)
        }
    }
    
    fileprivate func reloadButton(with orderStatus: ZXUCOrderStatus) {
        self.orderStatus = orderStatus
        self.btnControl1.isHidden = false
        self.btnControl2.isHidden = false
        self.control1ButtonWidth.constant = 80
        
        btnControl1.backgroundColor = UIColor.zx_tintColor
        btnControl1.layer.borderColor = UIColor.zx_tintColor.cgColor
        btnControl1.setTitleColor(.white, for: .normal)
        
        btnControl2.backgroundColor = UIColor.white
        btnControl2.layer.borderColor = UIColor.zx_tintColor.cgColor
        btnControl2.setTitleColor(UIColor.zx_tintColor, for: .normal)
        
        switch orderStatus {
            case .waitDispatch,.waitTake: //待提货 (Control: 取消订单、查看提货码) //待发货 (Control: 取消订单、查看提货码)
                control1ButtonWidth.constant = 94
                btnControl1.setTitle("查看提货码", for: .normal)
                btnControl1.backgroundColor = UIColor.zx_colorRGB(53, 167, 144, 1.0)
                btnControl1.layer.borderColor = UIColor.zx_colorRGB(53, 167, 144, 1.0).cgColor
                
                btnControl2.setTitle("取消订单", for: .normal)
            case .waitPay:       /*待支付*/
                btnControl1.setTitle("立即付款", for: .normal)
                btnControl2.setTitle("取消订单", for: .normal)
            
            case .dispatched:    /*已发货-UI待收货*/
                control1ButtonWidth.constant = 94
                btnControl1.setTitle("查看提货码", for: .normal)
                btnControl1.backgroundColor = UIColor.zx_colorRGB(53, 167, 144, 1.0)
                btnControl1.layer.borderColor = UIColor.zx_colorRGB(53, 167, 144, 1.0).cgColor
                
                btnControl2.setTitle("确认收货", for: .normal)
            case .canceled,.finished:      //已完成 (Control: 删除订单) //已取消 (Control: 删除订单)
                btnControl1.setTitle("删除订单", for: .normal)
                btnControl1.backgroundColor = UIColor.white
                btnControl1.layer.borderColor = UIColor.zx_tintColor.cgColor
                btnControl1.setTitleColor(UIColor.zx_tintColor, for: .normal)
                
                btnControl2.isHidden = true
            case .preparing:    /*备货中-取消订单*/
                btnControl1.setTitle("取消订单", for: .normal)
                btnControl1.backgroundColor = UIColor.white
                btnControl1.layer.borderColor = UIColor.zx_tintColor.cgColor
                btnControl1.setTitleColor(UIColor.zx_tintColor, for: .normal)
                
                btnControl2.isHidden = true
            default: //refunding invalid all
                self.btnControl1.isHidden = true
                self.btnControl2.isHidden = true
        }
    }
    
}
