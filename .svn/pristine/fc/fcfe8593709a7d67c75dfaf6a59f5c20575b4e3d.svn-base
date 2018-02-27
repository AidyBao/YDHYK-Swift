//
//  ZXEidtAddressViewController.swift
//  YDHYK
//
//  Created by 120v on 2017/11/9.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXEidtAddressViewController: ZXUITableViewController {

    static let EidtAddress_Segue: String = "ZXEidtAddress"
    
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var telLb: UILabel!
    @IBOutlet weak var addressLb: UILabel!
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var telText: UITextField!
    @IBOutlet weak var detailAddrLb: UILabel!
    @IBOutlet weak var detailAddrView: ZXTextView!
    
    var addressModel: ZXAddressModel = ZXAddressModel()
    var isNewAdd: Bool = false
    var cityAddress: String = ""
    var cityAddressCode: String = ""
    
    class func loadStoryBoard() -> ZXEidtAddressViewController {
        return UIStoryboard.init(name: "EditProfile", bundle: nil).instantiateViewController(withIdentifier: EidtAddress_Segue) as! ZXEidtAddressViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUIStyle()
        
        self.addSave()
        
        self.setDefault()
        
        self.setSaveButtonStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(zxTextFieldDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    func setUIStyle() {
        
        if self.isNewAdd == true {
            self.navigationItem.title = "添加地址";
        }else if self.isNewAdd == false {
            self.navigationItem.title = "编辑地址";
        }
        
        self.view.backgroundColor = UIColor.zx_subTintColor
        self.tableView.backgroundColor = UIColor.zx_subTintColor
        
        self.nameLB.textColor = UIColor.zx_textColorTitle
        self.telLb.textColor = UIColor.zx_textColorTitle
        self.addressLb.textColor = UIColor.zx_textColorTitle
        
        self.nameText.textColor = UIColor.zx_textColorMark
        self.telText.textColor = UIColor.zx_textColorMark
        self.detailAddrLb.textColor = UIColor.zx_textColorMark
        
        if self.isNewAdd {
            self.detailAddrView.placeText = "请填写详细地址"
        }
        self.detailAddrView.delegate = self
        self.detailAddrView.limitTextNum = 64
    }
    
    func addSave() {
        self.saveButton.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        self.saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.saveButton.setTitle("保存", for: .normal)
        self.saveButton.addTarget(self, action: #selector(saveButAction(_:)), for: .touchUpInside)
        let rightItem:UIBarButtonItem = UIBarButtonItem.init(customView: self.saveButton)
        let rightSpace = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightSpace.width = 0
        self.navigationItem.rightBarButtonItems = [rightSpace,rightItem]
        self.saveButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
        self.saveButton.isEnabled = false
    }
    
    func setDefault() {
        self.nameText.text = self.addressModel.consignee
        
        self.telText.text = self.addressModel.tel
        
        let aArray: Array = (self.addressModel.cityAddress.components(separatedBy: "-"))
        let newStr: String = aArray.joined(separator: "")
        self.detailAddrLb.text = newStr
        
        self.detailAddrView.textView.text = self.addressModel.detailAddress
        
        self.cityAddress = self.addressModel.cityAddress
        
        self.cityAddressCode = self.addressModel.code
    }
    
    //MARK: - saveButtonClick
    @objc func saveButAction(_ sender:UIButton) -> Void {
        if self.isNewAdd {
            self.addAndModifyAddress(true)
        }else{
            self.addAndModifyAddress(false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var saveButton: UIButton = {
        let btn:UIButton = UIButton.init(type: .custom)
        return btn
    }()
}

extension ZXEidtAddressViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if self.isNewAdd {
            return 1
        }
        return 2
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        var cellHeight:CGFloat = 0.0;
//        if self.isNewAdd == true {
//            if indexPath.section == 1 {
//                cellHeight = 0
//            }else if indexPath.section == 0 , indexPath.row == 3{
//                cellHeight = 81
//            }else{
//                cellHeight = 50
//            }
//        }
//        if self.isNewAdd == false {
//            if indexPath.section == 0 , indexPath.row == 3{
//                cellHeight = 81
//            }else{
//                cellHeight = 50
//            }
//        }
//        return cellHeight
//    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 10.0
        }
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 2:
                self.telText.resignFirstResponder()
                self.nameText.resignFirstResponder()
                self.detailAddrView.textView.resignFirstResponder()
                
                let addressVC = ZXAddressViewController.init()
                addressVC.hidesBottomBarWhenPushed = true
                addressVC.navigationController?.setNavigationBarHidden(true, animated: true)
                addressVC.delegate = self
                self.present(addressVC, animated: true, completion: nil)
                if self.cityAddressCode.isEmpty == false {
                    addressVC.setDefaultAddress(self.cityAddressCode)
                }
            default:
                self.view.endEditing(true)
            }
        case 1:
            switch indexPath.row {
            case 0:
                self.deleted()
            default:
                self.view.endEditing(true)
            }
        default:
            self.view.endEditing(true)
        }
    }
}

//MARK: - ZXAddressViewControllerDelegate
extension ZXEidtAddressViewController: ZXAddressViewControllerDelegate {
    func didSelectedAddressView(_ proviceStr:String,_ proCode:Int,_ cityStr:String,_ cityCode:Int,_ disStr:String,_ disCode:Int) {
        if proviceStr != "", cityStr != "",cityStr != "" {
            let areaStr: String = NSString.init(format: "%@%@%@", proviceStr,cityStr,disStr) as String
            //            self.cityAddress = NSString.init(format: "%@-%@-%@", proviceStr,cityStr,disStr) as String
            self.cityAddress = areaStr
            self.detailAddrLb.text = areaStr
        }
        
        if proCode != -1,cityCode != -1,disCode != -1 {
            self.cityAddressCode = NSString.init(format: "%d-%d-%d", proCode,cityCode,disCode) as String
        }
        self.setSaveButtonStyle()
    }
}

//MARK: - ZXTextViewDelegate
extension ZXEidtAddressViewController:ZXTextViewDelegate {
    func getTextNum(textNum: Int) {
        if textNum == 0 {
            self.detailAddrView.placeLabel.isHidden = false
            self.detailAddrView.placeText = "请填写详细地址"
        }else{
            self.detailAddrView.placeLabel.isHidden = true
        }
        self.setSaveButtonStyle()
    }
}

// MARK: -
extension ZXEidtAddressViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.nameText {
            if range.location + string.count > 16 {
                ZXHUD.showFailure(in: self.view, text: "姓名不能超过16个字", delay: ZX.HUDDelay)
                return false
            }
            
            if  (textField.textInputMode?.primaryLanguage!.isEqual("emoji")) == true || ((textField.textInputMode?.primaryLanguage) == nil){
                return false
            }
        }
        if textField == telText {
            if range.location + string.count > 11 {
                ZXHUD.showFailure(in: self.view, text: "请输入正确的手机号", delay: ZX.HUDDelay)
                return false
            }
        }
        return true
    }
    
    @objc func zxTextFieldDidChange(_ textField: UITextField) {
        self.setSaveButtonStyle()
    }
    
    func setSaveButtonStyle() {
        if self.nameText.text?.count == 0 ||
            self.telText.text?.count == 0 ||
            self.detailAddrLb.text?.count == 0 || self.detailAddrView.textView.text.count == 0 {
            self.saveButton.isEnabled = false
            self.saveButton.setTitleColor(UIColor.zx_textColorMark, for: .normal)
        }else{
            let aArray:Array = self.addressModel.cityAddress.components(separatedBy: "-")
            let cityStr:String = aArray.joined(separator: "")
            if self.isNewAdd == false,(self.nameText.text?.isEqual(self.addressModel.consignee))!,(self.telText.text?.isEqual(self.addressModel.tel))! ,(self.detailAddrLb.text?.isEqual(cityStr))!,(self.detailAddrView.textView.text?.isEqual(self.addressModel.detailAddress))! {
                self.saveButton.isEnabled = false
                self.saveButton.setTitleColor(UIColor.zx_textColorMark, for: .normal)
            }else{
                self.saveButton.isEnabled = true
                self.saveButton.setTitleColor(UIColor.white, for: .normal)
            }
        }
    }
}

//MARK: - HTTP
extension ZXEidtAddressViewController {
    
    //MARK: - 保存
    func addAndModifyAddress(_ isAdd:Bool) {
        
        var dict:Dictionary<String,Any> = [:]
        if (self.nameText.text?.isEmpty)! {
            ZXHUD.showFailure(in: self.view, text: "姓名不能为空", delay: ZX.HUDDelay)
            return
        }else{
            dict["consignee"] = self.nameText.text
        }
        
        if (self.telText.text?.isEmpty)! {
            ZXHUD.showFailure(in: self.view, text: "手机号不能为空", delay: ZX.HUDDelay)
            return
        }else{
            if (self.telText.text?.zx_mobileValid())! {
                dict["tel"] = self.telText.text
            }else{
                ZXHUD.showFailure(in: self.view, text: "请输入正确的手机号", delay: ZX.HUDDelay)
                return
            }
        }
        
        if self.cityAddress.isEmpty {
            ZXHUD.showFailure(in: self.view, text: "所在地区不能为空", delay: ZX.HUDDelay)
            return
        }else{
            dict["cityAddress"] = self.cityAddress
            dict["code"] = self.cityAddressCode
        }
        
        if (self.detailAddrView.textView.text?.isEmpty)! {
            ZXHUD.showFailure(in: self.view, text: "详细地址不能为空", delay: ZX.HUDDelay)
            return
        }else{
            dict["detailAddress"] = self.detailAddrView.textView.text
        }
        
        var urlStr: String = ""
        if isAdd {
           urlStr = ZXAPI.api(address: ZXAPIConst.Personal.addAddress)
        }else{
            urlStr = ZXAPI.api(address: ZXAPIConst.Personal.updateAddress)
        }
        
        ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: nil)
        ZXNetwork.asyncRequest(withUrl: urlStr, params: dict, method: .post) { (succ, code, content, string, errMsg) in
            ZXHUD.hide(for: self.view, animated: true)
            if succ {
                if code == ZXAPI_SUCCESS {
                    var msg: String = ""
                    if isAdd {
                        msg = "地址添加成功"
                    }else{
                        msg = "地址保存成功"
                    }
                    ZXHUD.showSuccess(in: self.view, text: msg, delay: ZX.HUDDelay)
                    self.navigationController?.popViewController(animated: true)
                }else{
                    if isAdd {
                        ZXHUD.showFailure(in: self.view, text: "添加地址失败", delay: ZX.HUDDelay)
                    }else{
                        ZXHUD.showFailure(in: self.view, text: "保存地址失败", delay: ZX.HUDDelay)
                    }
                }
            }else if code != ZXAPI_LOGIN_INVALID{
                if isAdd {
                    ZXHUD.showFailure(in: self.view, text: "添加地址失败", delay: ZX.HUDDelay)
                }else{
                    ZXHUD.showFailure(in: self.view, text: "保存地址失败", delay: ZX.HUDDelay)
                }
            }
        }
    }
    
    //MARK: - 删除
    func deleted() {
        ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: nil)
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Personal.removeAddress), params: ["id":self.addressModel.addrId], method: .post) { (succ, code, content, string, errMsg) in
            ZXHUD.hide(for: self.view, animated: true)
            if succ {
                if code == ZXAPI_SUCCESS {
                    ZXHUD.showSuccess(in: self.view, text: "删除成功", delay: ZX.HUDDelay)
                    self.navigationController?.popViewController(animated: true)
                }else{
                    ZXHUD.showFailure(in: self.view, text: "删除失败", delay: ZX.HUDDelay)
                }
            }else if code != ZXAPI_LOGIN_INVALID{
                ZXHUD.showFailure(in: self.view, text: "删除失败", delay: ZX.HUDDelay)
            }
        }
    }
}
