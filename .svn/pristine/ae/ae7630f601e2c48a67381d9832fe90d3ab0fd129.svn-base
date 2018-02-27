//
//  ZXitemInputSearchHeader.swift
//  YDHYK
//
//  Created by screson on 2017/11/23.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

let ZXItemSearchTextFiledTag = 809001
let ZXItemSearchAddButtonTag = 809002

protocol ZXItemSearchDelegate: class {
    func zxItemSearchListSelectButtonAction()
    func zxItemSearchAddButtonAction()
    func zxItemSearchResultChanged(result: Array<ZXCheckItemListModel>)
}

class ZXitemInputSearchHeader: UITableViewHeaderFooterView, UITextFieldDelegate {

    let disableColor = UIColor.zx_colorRGB(181,213,252, 1.0)
    weak var delegate: ZXItemSearchDelegate?
    
    @IBOutlet weak var txtItemSearch: UITextField!
    
    @IBOutlet weak var btnAdd: ZXUIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .white
        self.btnAdd.tag = ZXItemSearchAddButtonTag
        
        self.txtItemSearch.layer.cornerRadius = 5
        self.txtItemSearch.font = UIFont.zx_titleFont(15)
        self.txtItemSearch.textColor = UIColor.zx_textColorTitle
        self.txtItemSearch.tag = ZXItemSearchTextFiledTag
        
        let imgSearch = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imgSearch.contentMode = .scaleAspectFit
        imgSearch.image = #imageLiteral(resourceName: "h_CheckItem_seach")
        self.txtItemSearch.leftView = imgSearch
        self.txtItemSearch.leftViewMode = .always
        let btnListSelect = UIButton.init(type: .custom)
        btnListSelect.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnListSelect.setImage(#imageLiteral(resourceName: "h_CheckItem_Select"), for: .normal)
        btnListSelect.addTarget(self, action: #selector(listSelectAction), for: .touchUpInside)
        self.txtItemSearch.rightView = btnListSelect
        self.txtItemSearch.rightViewMode = .unlessEditing
        self.txtItemSearch.delegate = self
        
        self.btnAdd.backgroundColor = self.disableColor
        btnAdd.isEnabled = false
    }
    
    @objc func listSelectAction() {
        delegate?.zxItemSearchListSelectButtonAction()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func addAction(_ sender: Any) {
        delegate?.zxItemSearchAddButtonAction()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.txtItemSearch.resignFirstResponder()
        self.btnAdd.isEnabled = false
        self.btnAdd.backgroundColor = self.disableColor
        self.txtItemSearch.text = ""
        self.searchItemListBy(key: nil)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.btnAdd.isEnabled = false
        self.btnAdd.backgroundColor = self.disableColor
        let text = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        self.searchItemListBy(key: text)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.btnAdd.isEnabled = false
        self.btnAdd.backgroundColor = self.disableColor
        self.searchItemListBy(key: nil)
        return true
    }
    
    func searchItemListBy(key: String?) {
        if let key = key, !key.isEmpty {
            if let list = ZXReportAnalyseViewModel.zx_allCheckItemListCache, list.count > 0 {
                //let predicate = NSPredicate.init(format: "itemName CONTAINS \(key.lowercased()) OR zx_pinyin BEGINSWITH \(key.lowercased()) OR itemName CONTAINS \(key.uppercased()) OR zx_pinyin BEGINSWITH \(key.uppercased()) OR zx_firstWordLetters CONTAINS \(key.lowercased()) OR zx_firstWordLetters CONTAINS \(key.uppercased())")
                let predicate = NSPredicate.init(format: "itemName CONTAINS %@ OR zx_pinyin BEGINSWITH %@ OR itemName CONTAINS %@ OR zx_pinyin BEGINSWITH %@ OR zx_firstWordLetters CONTAINS %@ OR zx_firstWordLetters CONTAINS %@",key.lowercased(),key.lowercased(),key.uppercased(),key.uppercased(),key.lowercased(),key.uppercased())

                let filterList = (list as NSArray).filtered(using: predicate)
                if let filterList = filterList as? Array<ZXCheckItemListModel> {
                    delegate?.zxItemSearchResultChanged(result: filterList)
                    return
                }
            }
        }
        delegate?.zxItemSearchResultChanged(result: [])
    }
    
}
