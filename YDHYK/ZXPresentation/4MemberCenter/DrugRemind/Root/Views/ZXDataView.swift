//
//  ZXDataView.swift
//  YDHYK
//
//  Created by 120v on 2017/11/23.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

enum ZXDateViewType {
    case Cancel,Delete
}

typealias ZXDateViewCompletion = ( _ dateStr: String, _ sender:UIButton, _ dateModel: ZXAddTimeModel?) -> Void

class ZXDataView: UIView {
    
    var dateType: ZXDateViewType = .Cancel
    var dateModel: ZXAddTimeModel?
    var completion: ZXDateViewCompletion?
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var titleLb: UILabel!

    var title: String = ""
    var cancelStr: String = ""
    var defaultDate: String = ""
    
    var hourStr: String = ""
    var minuteStr: String = ""
    
    static func loadNib() -> ZXDataView{
        let nibView:ZXDataView = Bundle.main.loadNibNamed("ZXDataView", owner: self, options: nil)?.first as! ZXDataView
        return nibView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = UIScreen.main.bounds
    }
    
    func setUI() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.cancelBtn.setTitleColor(UIColor.zx_tintColor, for: .normal)
        self.confirmBtn.setTitleColor(UIColor.zx_tintColor, for: .normal)
        
        //
        self.topView.backgroundColor = UIColor.zx_backgroundColor
        
        //
        self.titleLb.textColor = UIColor.zx_textColorTitle
        self.titleLb.font = UIFont.zx_titleFont
        
        //
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.selectRow(8, inComponent: 0, animated: true)
        self.pickerView.selectRow(6, inComponent: 1, animated: true)
    }
    
    //MARK: - 类型设置
    func loadDateUIWithType(_ type: ZXDateViewType,_ title: String, _ cancel: String,_ model: ZXAddTimeModel?) {
        
        self.dateModel = model
        self.dateType = type
        //UI
        self.titleLb.text = title
        self.cancelBtn.setTitle(cancel, for: .normal)
        if type == .Cancel {
            self.cancelBtn.setTitleColor(UIColor.zx_tintColor, for: .normal)
        }else if type == .Delete {
            self.cancelBtn.setTitleColor(UIColor.red, for: .normal)
        }
        //设置默认时间
        if model != nil {
            self.setDefaultDate(model)
        }
    }
    
    func setDefaultDate(_ model: ZXAddTimeModel?) {
        
        let st1 = model?.drugTime.index((model?.drugTime.startIndex)!, offsetBy: 11)
        let ed1 = model?.drugTime.index((model?.drugTime.startIndex)!, offsetBy: 13)
        let oldHour = model?.drugTime.substring(with: Range.init(uncheckedBounds: (lower: st1!, upper: ed1!)))
        
        let st2 = model?.drugTime.index((model?.drugTime.startIndex)!, offsetBy: 14)
        let ed2 = model?.drugTime.index((model?.drugTime.startIndex)!, offsetBy: 16)
        let oldMinute = model?.drugTime.substring(with: Range.init(uncheckedBounds: (lower: st2!, upper: ed2!)))

        self.hoursArray.enumerateObjects { (_ objc: Any, _ idx: Int, _ stop:UnsafeMutablePointer<ObjCBool>) in
            if let objc = objc as? String, objc == oldHour {
                self.pickerView.selectRow(idx, inComponent: 0, animated: true)
                self.hourStr = objc
                stop[0] = true
            }
        }
        
        self.minuteArray.enumerateObjects { (_ objc: Any, _ idx: Int, _ stop:UnsafeMutablePointer<ObjCBool>) in
            if let objc = objc as? String, objc == oldMinute {
                self.pickerView.selectRow(idx, inComponent: 1, animated: true)
                self.minuteStr = objc
                stop[0] = true
            }
        }
    }

    //MARK: - 取消
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        if self.dateType == .Delete && self.completion != nil {
            self.completion?("",sender,self.dateModel)
        }
        self.removeFromSuperview()
    }
    
    //MARK: - 确定
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        if self.hourStr.isEmpty {
            self.hourStr = "08"
        }
        if self.minuteStr.isEmpty {
            self.minuteStr = "30"
        }
        let currentData: String = ZXDateUtils.current.date(false)
        let dateStr: String = "\(currentData) \(self.hourStr):\(self.minuteStr):00"
        self.completion?(dateStr,sender,self.dateModel)
    }
    
    //MARK: - lazy
    lazy var hoursArray: NSMutableArray = {
        let arr: NSMutableArray =  ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
        return arr
    }()
    
    lazy var minuteArray: NSMutableArray = {
        let arr: NSMutableArray = ["00","05","10","15","20","25","30","35","40","45","50","55"]
        return arr
    }()
}

extension ZXDataView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerView.tintColorDidChange()
        switch (component) {
        case 0:
            let hourStr: String = self.hoursArray.object(at: row) as! String
            return hourStr
        case 1:
            let minuteStr: String = self.minuteArray.object(at: row) as! String
            return minuteStr
        default:
            break
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label: UILabel = UILabel.init()
        label.size = CGSize.init(width: 40, height: 21)
        label.backgroundColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.zx_titleFont
        label.textColor = UIColor.zx_textColorTitle
        switch (component) {
        case 0:
            let hourStr: String = self.hoursArray.object(at: row) as! String
            label.text = "\(hourStr)点"
        case 1:
            let minuteStr: String = self.minuteArray.object(at: row) as! String
            label.text = "\(minuteStr)分"
        default:
            break
        }
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (component) {
        case 0:
            self.hourStr = self.hoursArray.object(at: row) as! String
        case 1:
            self.minuteStr = self.minuteArray.object(at: row) as! String
        default:
            break;
        }
    }
}

extension ZXDataView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var rowNum: Int = 0
        switch (component) {
        case 0:
            rowNum = self.hoursArray.count
        case 1:
            rowNum = self.minuteArray.count
        default:
            break;
        }
        return rowNum
    }
    
    func rowSize(forComponent component: Int) -> CGSize {
        return CGSize.init(width: 40, height: 21)
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 34.0
    }

}
