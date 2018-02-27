//
//  ZXUserInfoCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/6.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 头像-姓名-积分  消息、设置、编辑
class ZXUserInfoCell: UITableViewCell {
    weak var delegate: ZXUserInfoMenuActionProtocol?
    
    static let height: CGFloat = 180
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbScores: UILabel!
    
    @IBOutlet weak var lbNewMessageCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        
        self.contentView.backgroundColor = UIColor.zx_tintColor
        
        lbNewMessageCount.font = UIFont.zx_titleFont(12)
        lbNewMessageCount.backgroundColor = UIColor.zx_customBColor
        lbNewMessageCount.layer.cornerRadius = 8
        lbNewMessageCount.layer.masksToBounds = true
        
        imgIcon.backgroundColor = UIColor.zx_borderColor
        imgIcon.layer.cornerRadius = 35
        imgIcon.layer.borderWidth = 1.0
        imgIcon.layer.borderColor = UIColor.white.cgColor
        
        lbScores.layer.cornerRadius = 9
        lbScores.layer.masksToBounds = true
        
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        var type: ZXUserMenuActionType = .none
        switch sender.tag {
            case 11:
                type = .messageList
            case 22:
                type = .setting
            case 33:
                type = .editInfo
            default:
                break
        }
        delegate?.zxUserInfoMenuHeaderAction(type: type)
    }
    
    func reloadData(model: ZXAllUnReadCountModel?) {
        lbNewMessageCount.isHidden = true
        let user = ZXUser.user
        if user.isLogin {
            var placeholderImage = #imageLiteral(resourceName: "touxiang-man")
            if user.sex == 0 {
                placeholderImage = #imageLiteral(resourceName: "touxiang-woman")
            }
            imgIcon.kf.setImage(with: URL.init(string: user.headPortraitFilesStr), placeholder: placeholderImage)
            lbName.text = user.name
            lbScores.text = "\(user.currentIntegral)积分"
            if let model = model {
                lbScores.text = "\(model.integral)积分"
                if model.promotionUnRead > 0 {
                    lbNewMessageCount.isHidden = false
                    lbNewMessageCount.text = "\(model.promotionUnRead)"
                }
            }
        }
    }
    
}
