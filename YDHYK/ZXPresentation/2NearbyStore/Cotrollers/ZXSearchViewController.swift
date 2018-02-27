//
//  ZXSearchViewController.swift
//  YDHYK
//
//  Created by 120v on 2017/11/8.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXSearchViewController: ZXUIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allArr = ZXSearchModel.findAll()! as NSArray

        self.setUIStyle()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchField.addTarget(self, action: #selector(zxTextFieldValueChange(_:)), for: UIControlEvents.editingChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: self)
    }
    
    func setUIStyle() {
        //Nav

        self.zx_addNavBarButtonItems(textNames: [""], font: nil, color: nil, at: .left)
        
        self.zx_addNavBarButtonItems(textNames: ["取消"], font: nil, color: nil, at: .right)
        
        self.tableView.backgroundColor = UIColor.zx_subTintColor
        self.tableView.register(UINib.init(nibName: String.init(describing: ZXStoreListCell.self), bundle: nil), forCellReuseIdentifier: ZXStoreListCell.ZXStoreListCellID)
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.titleView = self.searchField
        self.searchField.delegate = self
        self.searchField.becomeFirstResponder()
    }
    
    override func zx_rightBarButtonAction(index: Int) {
        self.navigationController?.popViewController(animated: false)
    }

    @objc func zxTextFieldValueChange(_ textField: UITextField) {
        let str: NSString = textField.text! as NSString
        //1.去除Emoji
        var keyStr: String = str.removedEmoji() as String
        //过滤
        keyStr = keyStr.zx_predicateSearch()
        
        if keyStr.count != 0 {
            //2.中文/字母/数字判断
            let isLetter = NSString.judegeCheseOrChart(keyStr as String!)
            //3.数据库查找
            if isLetter {//字母搜索
                self.queryWithEnlish(keyStr)
            }else{//中文搜索
                self.queryWithChinese(keyStr)
            }
        }else{
            self.searchArray.removeAll()
            ZXEmptyView.show(in: self.view, type: .noData, text: "无结果")
        }
    }
    
    //MARK: - 中文模糊查询
    func queryWithChinese(_ condition: String) {
        self.searchArray.removeAll()
        if condition.count != 0 {
            let sql: String = "WHERE name LIKE '%\(condition)%' OR address LIKE '%\(condition)%';"
            self.searchArray = ZXSearchModel.find(byCriteria: sql) as! Array<ZXSearchModel>
            //排序
            self.searchArray = self.sorted(self.searchArray)
            
            if self.searchArray.count != 0 {
                ZXEmptyView.hide(from: self.view)
            }else{
                ZXEmptyView.show(in: self.view, type: .noData, text: "无结果")
            }
        }else{
            ZXEmptyView.show(in: self.view, type: .noData, text: "无结果")
        }
        self.tableView.reloadData()
    }
    
    //MARK: - 英文字母模糊查询
    func queryWithEnlish(_ condition: String) {
        self.searchArray.removeAll()
        if condition.count != 0 {
            for model in self.allArr {
                if let mod: ZXSearchModel = model as? ZXSearchModel {
                    //1.把所有的搜索结果转成成拼音
                    let namePY = NSString.transform(toPinyin: mod.name)!
                    let addPY = NSString.transform(toPinyin: mod.address)!
                    if namePY.localizedCaseInsensitiveContains(condition) || addPY.localizedCaseInsensitiveContains(condition) {
                        if self.searchArray.count != 0 {
                            if self.searchArray.contains(mod) == false {
                                self.searchArray.append(mod)
                            }
                        }else{
                            self.searchArray.append(mod)
                        }
                    }
                }
            }
            //排序
            self.searchArray = self.sorted(self.searchArray)
            
            //
            if self.searchArray.count != 0 {
                ZXEmptyView.hide(from: self.view)
            }else{
                ZXEmptyView.show(in: self.view, type: .noData, text: "无结果")
            }
        }else{
            ZXEmptyView.show(in: self.view, type: .noData, text: "无结果")
        }
        self.tableView.reloadData()
    }
    
    //升序排序
    func sorted(_ array: Array<ZXSearchModel>) -> Array<ZXSearchModel> {
        let sortArray = array.sorted { (model1, model2) -> Bool in
            return model2.distance > model1.distance
        }
        return sortArray
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.searchField.frame = CGRect.init(x: 0, y: 0, width: ZX_BOUNDS_WIDTH - 60, height: 35)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Lazy
    lazy var allArr: NSArray = {
        let arr: NSArray = NSArray.init()
        return arr
    }()
    
    lazy var searchArray: Array<ZXSearchModel> = {
        let arr: Array<ZXSearchModel> = Array.init()
        return arr
    }()
    
    lazy var searchField:UITextField = {
        //
        let searchImg:UIImage = #imageLiteral(resourceName: "search")
        let leftImgV:UIImageView = UIImageView.init(image: searchImg)
        leftImgV.frame = CGRect.init(x: 30, y: 0, width: searchImg.size.width + 5, height: searchImg.size.height)
        leftImgV.contentMode = UIViewContentMode.right
        
        //
        let placeHoderlStr: String = "搜索药店、医馆"
        let search = UITextField.init()
        search.frame = CGRect.init(x: 0, y: 0, width: ZX_BOUNDS_WIDTH - 60, height: 35)
        search.tintColor = UIColor.zx_textColorBody
        search.leftViewMode = .always
        search.borderStyle = .none
        search.backgroundColor = UIColor.white
        search.clearButtonMode = .whileEditing
        search.borderStyle = .roundedRect
        search.leftView = leftImgV
        search.font = UIFont.zx_bodyFont(UIFont.zx_bodyFontSize - 2)
        search.textColor = UIColor.zx_textColorTitle
        search.returnKeyType = .done
        search.enablesReturnKeyAutomatically = true//设置无文本为灰色
        if #available(iOS 9.0, *) {
            let attrStr = NSAttributedString.init(string: placeHoderlStr, attributes: [NSAttributedStringKey.font:UIFont.zx_bodyFont(UIFont.zx_bodyFontSize - 2),NSAttributedStringKey.foregroundColor:UIColor.zx_textColorBody])
            search.attributedPlaceholder = attrStr
        }else {
            search.placeholder = placeHoderlStr
        }
        return search
    }()
}

extension ZXSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.textInputMode?.primaryLanguage!.isEqual("emoji")) == true || ((textField.textInputMode?.primaryLanguage) == nil) {
            return false
        }
        return true
    }
}

extension ZXSearchViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
        self.searchField.resignFirstResponder()
    }
}

extension ZXSearchViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ZXStoreListCell = tableView.dequeueReusableCell(withIdentifier: ZXStoreListCell.ZXStoreListCellID, for: indexPath) as! ZXStoreListCell
        cell.delegate = self
        if self.searchArray.count != 0 {
            let model: ZXSearchModel = self.searchArray[indexPath.row]
            cell.loadData(model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 143.0
    }
}

extension ZXSearchViewController: ZXStoreListCellDelegate {
    func didZXStoreListCell(_ sender: UIButton, _ model: ZXSearchModel) {
        switch sender.tag {
        case ZXStoreListCell.BtnTag.nav://定位
            if Float(model.latitude) != 0.0 , Float(model.longitude) != 0.0 {
                
                let vcArr: Array<Any> = (self.navigationController?.viewControllers)!
                var mapVC: ZXNearbyRootViewController = ZXNearbyRootViewController()
                for vc in vcArr.enumerated() {
                    if ((vc.element as? ZXNearbyRootViewController) != nil) {
                        mapVC = (vc.element as? ZXNearbyRootViewController)!
                    }
                }
                mapVC.isListVCLocationClick = true
                self.navigationController?.popToViewController(mapVC, animated: true)
                var mArr: Array<ZXSearchModel> = Array.init()
                mArr.append(model)
                mapVC.modelArray = mArr
                mapVC.loadDataForDetailView(mArr)
                
            }else{
                ZXHUD.showFailure(in: self.view, text: "定位失败", delay: ZX.HUDDelay)
                return
            }
        case ZXStoreListCell.BtnTag.tel://电话
            if model.tel.count != 0 {
                ZXCommonUtils.call(model.tel, failed: { (errMsg) in
                    ZXAlertUtils.showAlert(wihtTitle:"提示" , message: "该设备不支持拨打电话功能", buttonText: "知道了", action: nil)
                })
            }else{
                ZXHUD.showFailure(in: self.view, text: "无相关联系方式", delay: ZX.HUDDelay)
            }
        case ZXStoreListCell.BtnTag.join://加入会员
            if model.isMember == 0 {
                ZXJoinLeadViewController.checkShow(completion: {
                    self.navigationController?.pushViewController(ZXQRCodeScanViewController(), animated: true)
                })
            }
        case ZXStoreListCell.BtnTag.buy://购药
            if model.isMember == 1 {
                let storeVC = ZXStoreRootViewController.configVC(storeId: "\(model.storeId)", memberId: ZXUser.user.memberId, token: ZXUser.user.userToken)
                self.navigationController?.pushViewController(storeVC, animated: true)
            }
        default:
            break
        }
    }
}
