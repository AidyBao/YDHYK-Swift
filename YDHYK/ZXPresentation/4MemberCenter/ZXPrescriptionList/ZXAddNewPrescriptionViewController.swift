//
//  ZXAddNewPrescriptionViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/9.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXAddNewPrescriptionViewController: ZXUIViewController, UITextFieldDelegate {

    @IBOutlet weak var imgPrescription: UIImageView!
    @IBOutlet weak var txtRemark: UITextField!
    @IBOutlet weak var bottomOffset: NSLayoutConstraint!
    var image: UIImage?
    var uploadedPath: String?
    var isUploading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "新增处方"
        
        self.zx_addNavBarButtonItems(textNames: ["取消"], font: nil, color: nil, at: .left)
        self.zx_addNavBarButtonItems(textNames: ["保存"], font: nil, color: nil, at: .right)
        
        txtRemark.backgroundColor = .white
        txtRemark.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 49))
        txtRemark.leftViewMode = .always
        txtRemark.clearButtonMode = .whileEditing
        txtRemark.font = UIFont.zx_titleFont
        txtRemark.textColor = UIColor.zx_textColorTitle
        txtRemark.delegate = self
        txtRemark.placeholder = "添加文字说明(30字以内)"
        
        imgPrescription.image = image
        
        self.zx_addKeyboardNotification()
    }
    
    override func zx_leftBarButtonAction(index: Int) {
        ZXAlertUtils.showAlert(wihtTitle: "提示", message: "放弃保存处方?", buttonTexts: ["放弃","继续编辑"]) { (index) in
            if index == 0 {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func zx_rightBarButtonAction(index: Int) {
        self.view.endEditing(true)

        guard let image = image else {
            ZXHUD.showFailure(in: self.view, text: "请返回上传图片", delay: ZX.HUDDelay)
            return
        }
        if let remark = self.txtRemark.text, !remark.isEmpty {
            if isUploading {
                return
            }
            isUploading = true
            ZXHUD.showLoading(in: self.view, text: "数据上传中...", delay: 0)
            if let path = uploadedPath { //已上传 不再重复上传
                self.addPrescription(with: remark, image: path)
            } else {
                ZXNetwork.uploadImage(to: ZXAPI.file(address: ZXAPIConst.FileResouce.url), images: [image], params: ["directory": ZXAPIConst.FileResouce.chuFFolder], compressRatio: 1, completion: { (success, code, obj, _, error) in
                    ZXHUD.hide(for: self.view, animated: true)
                    if code == ZXAPI_SUCCESS {
                        if let path = obj["filePath"] as? String {
                            self.uploadedPath = path
                            self.addPrescription(with: remark, image: path)
                        } else {
                            ZXHUD.showFailure(in: self.view, text: "资源地址解析失败", delay: ZX.HUDDelay)
                            self.isUploading = false
                        }
                    } else {
                        ZXHUD.showFailure(in: self.view, text: error?.errorMessage ?? "未知错误", delay: ZX.HUDDelay)
                        self.isUploading = false
                    }
                })
            }
        } else {
            ZXHUD.showFailure(in: self.view, text: "请填写文字说明", delay: ZX.HUDDelay)
            return
        }
    }
    
    fileprivate func addPrescription(with remark: String,image path: String) {
        ZXHUD.showFailure(in: self.view, text: "正在提交数据...", delay: 0)
        ZXPrescriptionViewModel.add(with: remark, images: path, completion: { (success, errorMsg) in
            ZXHUD.hide(for: self.view, animated: true)
            self.isUploading = false
            if success {
                NotificationCenter.zxpost.prescriptionAdded()
                ZXHUD.showSuccess(in: self.view, text: "处方添加成功", delay: ZX.HUDDelay)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + ZX.CallDelay, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
            } else {
                ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
            }
        })
    }
    
    override func zx_keyboardWillChangeFrame(beginRect: CGRect, endRect: CGRect, duration dt: Double, userInfo: Dictionary<String, Any>) {
        bottomOffset.constant = endRect.size.height
        UIView.animate(withDuration: dt) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func zx_keyboardWillHide(duration dt: Double, userInfo: Dictionary<String, Any>) {
        bottomOffset.constant = 0
        UIView.animate(withDuration: dt) {
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: -
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location >= 30 {
            return false
        }
        return true
    }

}
