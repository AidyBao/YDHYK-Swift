//
//  ZXAddNewReportAnalyseViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/16.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 新增化验单
class ZXAddNewReportAnalyseViewController: ZXUIViewController {
    //来源拍照分析-暂时没有接口
    var imgReport: UIImage?
    var imgUrlString: String?
    var sexStr: String?
    var ageStr: String?
    var addedItemList: Array<ZXCheckItemDetailModel> = []//用户添加输入
    var searchList: Array<ZXCheckItemListModel> = []
    
    @IBOutlet weak var VTips: UIView!
    @IBOutlet weak var imgvSnap: UIImageView!
    @IBOutlet weak var topBackView: UIView!
    @IBOutlet weak var btnReviewImage: ZXUIButton!
    @IBOutlet weak var tblReportItem: UITableView!
    
    @IBOutlet weak var tblBottomOffset: NSLayoutConstraint!
    @IBOutlet weak var searchResultBackView: UIView!
    @IBOutlet weak var tblSerachResult: UITableView!
    @IBOutlet weak var lbNoResultInfo: UILabel!
    
    @IBOutlet weak var maskView: UIView!
    
    @IBOutlet weak var lbTipsInfo: UILabel!
    @IBOutlet weak var tipsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topBackHeight: NSLayoutConstraint! // 110 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "化验单分析"
        // Do any additional setup after loading the view.
        self.zx_addNavBarButtonItems(textNames: ["模板"], font: nil, color: nil, at: .right)
        self.view.backgroundColor = UIColor.zx_subTintColor
        if imgUrlString == nil && imgReport == nil {
            topBackHeight.constant = 0
        } else {
            topBackHeight.constant = 110
            if let url = imgUrlString {
                self.imgvSnap.kf.setImage(with: URL.init(string: url))
            } else {
                self.imgvSnap.image = imgReport
            }
        }
        self.VTips.backgroundColor = UIColor.zx_subTintColor
        self.lbTipsInfo.font = UIFont.zx_bodyFont(12)
        self.lbTipsInfo.textColor = UIColor.zx_tintColor
        self.lbTipsInfo.text = "分析结果仅作参考,具体请以医师分析为准。"
        
        self.maskView.backgroundColor = UIColor.zx_colorRGB(0, 0, 0, 0.1)
        self.maskView.isHidden = true
        self.maskView.alpha = 0
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapMaskView))
        self.maskView.addGestureRecognizer(tapGesture)
        
        self.searchResultBackView.clipsToBounds = true
        self.searchResultBackView.isHidden = true
        self.searchResultBackView.alpha = 0
        
        self.zx_addKeyboardNotification()
        
        //新增录入的检查项
        self.tblReportItem.backgroundColor = UIColor.zx_subTintColor
        self.tblReportItem.separatorColor = UIColor.zx_borderColor
        self.tblReportItem.tableFooterView = UIView.init(frame: CGRect.zero)
        self.tblReportItem.register(UINib.init(nibName: ZXItemInputCell.NibName, bundle: nil), forCellReuseIdentifier: ZXItemInputCell.reuseIdentifier)
        self.tblReportItem.register(UINib.init(nibName: ZXAgeSexInputCell.NibName, bundle: nil), forCellReuseIdentifier: ZXAgeSexInputCell.reuseIdentifier)
        self.tblReportItem.register(UINib.init(nibName: ZXitemInputSearchHeader.NibName, bundle: nil), forHeaderFooterViewReuseIdentifier: ZXitemInputSearchHeader.reuseIdentifier)
        //检索检查项
        self.tblSerachResult.backgroundColor = UIColor.white
        self.tblSerachResult.separatorColor = UIColor.zx_borderColor
        self.tblSerachResult.register(UINib.init(nibName: ZXTemplateItemCell.NibName, bundle: nil), forCellReuseIdentifier: ZXTemplateItemCell.reuseIdentifier)
        
        self.lbNoResultInfo.font = UIFont.zx_titleFont(30)
        self.lbNoResultInfo.textColor = UIColor.zx_subTintColor
        self.lbNoResultInfo.isHidden = true
        
        self.loadCheckItemList(showHUD: true)

    }
    
    @objc func tapMaskView() {
        self.view.endEditing(true)
    }
    
    func loadCheckItemList(showHUD: Bool) {
        if showHUD {
            ZXHUD.showLoading(in: self.view, text: "获取检查项列表", delay: 0)
        }
        ZXReportAnalyseViewModel.checkItemListBy(templateKey: nil) { (success, code, list, errorMsg) in
            ZXHUD.hide(for: self.view, animated: true)
            if success {
                if list == nil {
                    ZXHUD.showFailure(in: self.view, text: "无可用的检查项数据", delay: ZX.HUDDelay)
                }
            } else {
                if code != ZXAPI_LOGIN_INVALID {
                    ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.tipsViewHeight.constant < 30 {
            self.tipsViewHeight.constant = 30
            UIView.animate(withDuration: 0.3, animations: {
              self.view.layoutIfNeeded()
            })
        }
    }
    //MARK: - 模板选择
    override func zx_rightBarButtonAction(index: Int) {
        let templateVC = ZXReportTemplateSelectViewController()
        templateVC.checkEnd = { list in
            if self.addedItemList.count > 0 {//已经添加过检查项
                ZXAlertUtils.showAlert(wihtTitle: nil, message: "是否使用模板检查项数据替换当前检查项?", buttonTexts: ["替换","取消"], action: { (index) in
                    if index == 0 {
                        self.addedItemList.removeAll()
                        for item in list {
                            if let model = ZXCheckItemDetailModel.mj_object(withKeyValues: item.mj_keyValues()) {
                                self.addedItemList.insert(model, at: 0)
                            }
                        }
                        self.tblReportItem.reloadData()
                    }
                })
            } else {
                for item in list {
                    if !self.hasAddedItem(item) {
                        if let model = ZXCheckItemDetailModel.mj_object(withKeyValues: item.mj_keyValues()) {
                            self.addedItemList.insert(model, at: 0)
                        }
                    }
                }
                self.tblReportItem.reloadData()

            }
        }
        self.navigationController?.pushViewController(templateVC, animated: true)
    }
    
    func hasAddedItem(_ item: ZXCheckItemListModel) -> Bool {
        var added = false
        if addedItemList.count > 0 {
            for aItem in addedItemList {
                if aItem.id == item.id {
                    added = true
                    break
                }
            }
        }
        return added
    }
    
    //MARK: - Clear Action
    @IBAction func clearAction(_ sender: UIButton) {
        self.view.endEditing(true)
        ZXAlertUtils.showAlert(wihtTitle: nil, message: "确定清空所有数据?", buttonTexts: ["清空", "取消"]) { (index) in
            if index == 0 {
                self.clearAll()
            }
        }
    }
    
    func clearAll() {
        ageStr = nil
        sexStr = nil
        addedItemList.removeAll()
        tblReportItem.reloadData()
    }
    //MARK: - StartAnalyseAction
    @IBAction func startAnalyse(_ sender: UIButton) {
        guard let age = ageStr else {
            ZXHUD.showFailure(in: self.view, text: "请填写年龄", delay: ZX.HUDDelay)
            return
        }
        guard let sex = sexStr else {
            ZXHUD.showFailure(in: self.view, text: "请选择性别", delay: ZX.HUDDelay)
            return
        }
        if addedItemList.count == 0 {
            ZXHUD.showFailure(in: self.view, text: "请添加至少一个检查项", delay: ZX.HUDDelay)
            return
        }
        if !self.isItemListInputRight() {
            ZXHUD.showFailure(in: self.view, text: "请将检查项数据录入完整", delay: ZX.HUDDelay)
            return
        }
        ZXHUD.showLoading(in: self.view, text: "数据分析中...", delay: 0)
        ZXReportAnalyseViewModel.addNewAnalyse(age: age, sex: sex, itemList: addedItemList, imgUrl: nil) { (success, code, reportId, isAbnormal, errorMsg) in
            ZXHUD.hide(for: self.view, animated: true)
            if success {//上传完成 调整到查看分析结果分析结果详情
                self.clearAll()
                let resultVC = ZXAnalyseResultViewController()
                resultVC.reportId = reportId
                resultVC.isAbnormal = isAbnormal
                resultVC.pushFromNewReportVC = true
                self.navigationController?.pushViewController(resultVC, animated: true)
            } else {
                ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
            }
        }
    }
    
    fileprivate func isItemListInputRight () -> Bool {
        if self.addedItemList.count > 0 {
            var inputRight = true
            for item in addedItemList {
                switch item.zx_referenceValueTypeKey {
                    case .valueType:
                        if item.resultValue.isEmpty ||
                            item.referenceMaxValue.isEmpty ||
                            item.referenceMinValue.isEmpty {
                            inputRight = false
                        }
                    case .yyTextType:
                        if item.referenceNegativePositive.isEmpty ||
                            item.resultNegativePositive.isEmpty {
                            inputRight = false
                        }
                    case .plus_minusType:
                        if item.referenceAddSub.isEmpty ||
                            item.resultAddSub.isEmpty {
                            inputRight = false
                        }
                    default:
                        break
                }
                if !inputRight {
                    break
                }
            }
            return inputRight
        }
        return false
    }
    //MARK: - Report List
    @IBAction func reportListAction(_ sender: UIButton) {
        let list = ZXReportAnalyseListViewController()
        self.navigationController?.pushViewController(list, animated: true)
    }
    
    @IBAction func reviewSourceImage(_ sender: UIButton) {
        
    }
    var txtSearch: UITextField {
        return self.tblReportItem.viewWithTag(ZXItemSearchTextFiledTag) as! UITextField
    }
    var txtAge: UITextField {
        return self.tblReportItem.viewWithTag(ZXItemInputAgeTextFiledTag) as! UITextField
    }
    
    var btnAdd: UIButton {
        return self.tblReportItem.viewWithTag(ZXItemSearchAddButtonTag) as! UIButton
    }
    var searchListIndex = -1
}

extension ZXAddNewReportAnalyseViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tblSerachResult {//
            if searchListIndex == indexPath.row {
                return
            }
            searchListIndex = indexPath.row
            let model = self.searchList[indexPath.row]
            self.txtSearch.text = model.itemName
            if let button = self.tblReportItem.viewWithTag(ZXItemSearchAddButtonTag) as? UIButton {
                button.isEnabled = true
                button.backgroundColor = UIColor.zx_tintColor
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tblReportItem {
            if indexPath.section == 0 {
                return 45
            }
            return 75
        }
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if  section == 1 {
            return 50
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return CGFloat.leastNormalMagnitude
        }
        return 10
    }
}

extension ZXAddNewReportAnalyseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tblReportItem {
            if section == 0 {
                return 1
            } else {
                return self.addedItemList.count
            }
        } else if tableView == self.tblSerachResult {
            return self.searchList.count
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.tblReportItem {
            return 2
        } else if tableView == self.tblSerachResult {
            if self.searchList.count > 0 {
                self.lbNoResultInfo.isHidden = true
                return 1
            } else {
                self.lbNoResultInfo.isHidden = false
                return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tblReportItem {
            if indexPath.section == 0 {//年龄 性别
                let cell = tableView.dequeueReusableCell(withIdentifier: ZXAgeSexInputCell.reuseIdentifier, for: indexPath) as! ZXAgeSexInputCell
                cell.delegate = self
                cell.reloadData(sex: sexStr, age: ageStr)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ZXItemInputCell.reuseIdentifier, for: indexPath) as! ZXItemInputCell
                cell.delegate = self
                cell.reloadData(model: self.addedItemList[indexPath.row])
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXTemplateItemCell.reuseIdentifier, for: indexPath) as! ZXTemplateItemCell
            cell.lbName.text = self.searchList[indexPath.row].itemName
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == self.tblReportItem, section == 1 { //检查项搜索
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ZXitemInputSearchHeader.reuseIdentifier) as! ZXitemInputSearchHeader
            view.delegate = self
            return view
        }
        return nil
    }
    
    
}

extension ZXAddNewReportAnalyseViewController {
    override func zx_keyboardWillShow(duration dt: Double, userInfo: Dictionary<String, Any>) {
        self.tblReportItem.isScrollEnabled = false
        if self.txtAge.isFirstResponder {//检索输入
            self.setMaskViewShow(show: true, animation: dt)
        } else if self.txtSearch.isFirstResponder {//年龄输入
            UIView.animate(withDuration: dt, animations: {
                self.tblReportItem.contentOffset = CGPoint(x: 0, y: 45 + 10)//cellheight + footer height
            })
            self.setSeachTableShow(show: true, animation: dt)
        } else {//录入数值时
            UIView.animate(withDuration: dt, animations: {
                self.tblReportItem.contentOffset = CGPoint(x: 0, y: 45 + 10)//cellheight + footer height
            })
        }
    }
    
    override func zx_keyboardWillChangeFrame(beginRect: CGRect, endRect: CGRect, duration dt: Double, userInfo: Dictionary<String, Any>) {
        self.tblBottomOffset.constant = endRect.size.height - 50 ///底部菜单高 50
        UIView.animate(withDuration: dt) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func zx_keyboardWillHide(duration dt: Double, userInfo: Dictionary<String, Any>) {
        self.tblReportItem.isScrollEnabled = true
        self.tblBottomOffset.constant = 0
        UIView.animate(withDuration: dt) {
            self.view.layoutIfNeeded()
        }
        self.setMaskViewShow(show: false, animation: dt)
        self.setSeachTableShow(show: false, animation: dt)
    }
    
    //MARK: - 切换控制
    
    fileprivate func setSeachTableShow(show: Bool,animation interval: TimeInterval) {
        if show == !self.searchResultBackView.isHidden {
            return
        }
        if show {
            self.maskView.isHidden = true
            self.searchResultBackView.isHidden = false
            UIView.animate(withDuration: interval, animations: {
                self.searchResultBackView.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration:interval, animations: {
                self.searchResultBackView.alpha = 0
            }, completion: { (finished) in
                self.searchResultBackView.isHidden = true
            })
        }
    }
    
    fileprivate func setMaskViewShow(show: Bool, animation interval: TimeInterval) {
        if show == !self.maskView.isHidden {
            return
        }
        if show {
            self.searchResultBackView.isHidden = true
            self.maskView.isHidden = false
            UIView.animate(withDuration: interval, animations: {
                self.maskView.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: interval, animations: {
                self.maskView.alpha = 0
            }, completion: { (finished) in
                self.maskView.isHidden = true
            })
        }
    }
}
