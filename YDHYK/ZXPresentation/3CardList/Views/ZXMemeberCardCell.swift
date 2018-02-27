//
//  ZXMemeberCardCell.swift
//  YDHYK
//
//  Created by 120v on 2017/11/7.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

protocol ZXMemeberCardCellDelegate: NSObjectProtocol {
    func didMemeberCardCellBuyAction(_ sender:UIButton,_ model: ZXMemberCardModel)
    func didMemeberCardCellTelAction(_ sender:UIButton,_ model: ZXMemberCardModel)
}

class ZXMemeberCardCell: UITableViewCell {
    
    static let ZXMemeberCardCellID: String = "ZXMemeberCardCell"
    weak var delegate: ZXMemeberCardCellDelegate?
    
    @IBOutlet weak var backImgView: UIImageView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var integerLb: UILabel!
    @IBOutlet weak var ticketLb: UILabel!
    @IBOutlet weak var telBtn: UIButton!
    @IBOutlet weak var sepLine: UIView!
    var cardModel: ZXMemberCardModel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        self.contentView.backgroundColor = UIColor.zx_subTintColor
        
        self.backImgView.layer.cornerRadius = 10.0
        self.backImgView.layer.masksToBounds = true
        
        self.icon.layer.cornerRadius = self.icon.height*0.5
        self.icon.layer.masksToBounds = true
    }
    
    func setBackView(_ cellIndex:NSInteger) {
        if cellIndex % 3 == 0 {
            self.backImgView.image = #imageLiteral(resourceName: "Backboard-deep-blue")
          }else if (cellIndex - 1) % 3 == 0 {
            self.backImgView.image = #imageLiteral(resourceName: "Backboard-blue")
        }else if (cellIndex - 2) % 3 == 0{
            self.backImgView.image = #imageLiteral(resourceName: "Backboard-green")
        }
    }
    
    func loadData(_ model: ZXMemberCardModel) {
        
        self.cardModel = model
        
        self.icon.kf.setImage(with: URL.init(string: model.headPortraitStr), placeholder: UIImage.Default.drug, options: nil, progressBlock: nil, completionHandler: nil)
        
        self.nameLb.text = model.drugstoreName
        
        self.integerLb.text = "积分:\(model.integral)分"
        
        self.ticketLb.text = "现金券:\(model.couponNum)张"
        
    }
    
    @IBAction func buyAction(_ sender: UIButton) {
        if delegate != nil {
            self.delegate?.didMemeberCardCellBuyAction(sender, self.cardModel)
        }
    }
    
    @IBAction func telAction(_ sender: UIButton) {
        if delegate != nil {
            self.delegate?.didMemeberCardCellTelAction(sender, self.cardModel)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}