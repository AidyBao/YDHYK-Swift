//
//  ZXMessageListCell.swift
//  YDHYK
//
//  Created by screson on 2017/11/10.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXMessageListCell: UITableViewCell {
    
    @IBOutlet weak var readedDot: ZXUIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var titleLeftOffset: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.lbTitle.font = UIFont.zx_titleFont
        self.lbTitle.textColor = UIColor.zx_textColorBody
        self.lbTitle.highlightedTextColor = UIColor.zx_textColorTitle
        
        self.lbContent.font = UIFont.zx_titleFont(13)
        self.lbContent.textColor = UIColor.zx_textColorBody
        
        self.lbDate.font = UIFont.zx_titleFont(13)
        self.lbDate.textColor = UIColor.zx_textColorMark
    }
    
    func reloadData(model: ZXMessageSortModel?) {
        readedDot.isHidden = true
        self.lbTitle.text = ""
        self.lbContent.text = ""
        self.lbDate.text = ""
        if let model = model {
            self.lbTitle.text = model.zx_description
            self.lbContent.text = model.title
            self.lbDate.text = model.sendDateStr
            if model.isRead == 1 {
                readedDot.isHidden = true
                lbTitle.isHighlighted = false
                titleLeftOffset.constant = 20
            } else {
                readedDot.isHidden = false
                lbTitle.isHighlighted = true
                titleLeftOffset.constant = 40
            }
        }
    }
    
}
