//
//  ZXPrescriptionViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/6.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
import JXPhotoBrowser

/// 新增处方列表
class ZXPrescriptionViewController: ZXUIViewController {

    @IBOutlet weak var tblList: UITableView!
    var currentPage = 1
    var dataList: Array<ZXPrescriptionModel> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "处方"
        // Do any additional setup after loading the view.
        self.zx_addNavBarButtonItems(imageNames: ["h_nav_add"], useOriginalColor: false, at: .right)
        
        self.tblList.backgroundColor = UIColor.zx_subTintColor
        
        self.tblList.register(UINib.init(nibName: ZXPrescriptionCell.NibName, bundle: nil), forCellReuseIdentifier: ZXPrescriptionCell.reuseIdentifier)
        self.tblList.zx_addHeaderRefresh(showGif: true, target: self, action: #selector(zx_refresh))
        self.tblList.zx_addFooterRefresh(autoRefresh: true, target: self, action: #selector(zx_loadmore))
        self.tblList.mj_header.beginRefreshing()
        
        NotificationCenter.default.addObserver(self, selector: #selector(zx_refresh), name: ZXNotification.Prescription.addSuccess.zx_noticeName(), object: nil)
        
    }
    
    override func zx_refresh() {
        currentPage = 1
        self.loadPrescriptionList(showHUD: false)
    }
    
    override func zx_loadmore() {
        currentPage += 1
        self.loadPrescriptionList(showHUD: false)
    }
    
    func loadPrescriptionList(showHUD: Bool) {
        if showHUD {
            ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
        }
        ZXPrescriptionViewModel.list(pageNum: currentPage, pageSize: ZX.PageSize) { (success, code, list, errorMsg) in
            ZXHUD.hide(for: self.view, animated: true)
            self.tblList.mj_header.endRefreshing()
            self.tblList.mj_footer.endRefreshing()
            ZXEmptyView.hide(from: self.tblList)
            ZXEmptyView.hide(from: self.view)
            if success {
                if let list = list {
                    if self.currentPage == 1 {
                        self.dataList = list
                    } else {
                        self.dataList.append(contentsOf: list)
                    }
                    if self.dataList.count < ZX.PageSize {
                        self.tblList.mj_footer.endRefreshingWithNoMoreData()
                    }
                    self.tblList.reloadData()
                }
                if self.dataList.count == 0 {
                    ZXEmptyView.show(in: self.tblList, type: .noData, text: "您还没有处方记录,\n可点击右上角+号添加保存")
                }
            } else {
                if code != ZXAPI_LOGIN_INVALID {
                    if self.dataList.count > 0 {//之前有数据，再次获取时网络出错
                        if code == ZXAPI_HTTP_TIME_OUT {
                            ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                        } else {
                            ZXHUD.showFailure(in: self.view, text: "此时无法访问服务器", delay: ZX.HUDDelay)
                        }
                    } else {//第一次获取数据就出错 详细网络连接错误
                        if code == ZXAPI_HTTP_ERROR {
                            ZXEmptyView.show(in: self.view, type: .networkError, text: nil, retry: {
                                self.loadPrescriptionList(showHUD: true)
                            })
                        } else {
                            ZXEmptyView.show(in: self.tblList, type: .noData, text: "您还没有处方记录,\n可点击右上角+号添加保存")
                            ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                        }
                    }
                } else {
                    if self.dataList.count == 0 {
                        ZXEmptyView.show(in: self.tblList, type: .noData, text: "您还没有处方记录,\n可点击右上角+号添加保存")
                    }
                }
            }
        }
    }
    lazy var imagepicker = HImagePickerUtils()
    override func zx_rightBarButtonAction(index: Int) {
        ZXAlertUtils.showActionSheet(withTitle: "添加处方", message: nil, buttonTexts: ["拍照", "从手机相册取"], cancelText: nil) { (index) in
            if index == 0 {
                self.imagepicker.takePhoto(presentFrom: self, completion: { [unowned self] (image, status) in
                    if status == .success {
                        let addNewVC = ZXAddNewPrescriptionViewController()
                        addNewVC.image = image
                        self.navigationController?.pushViewController(addNewVC, animated: true)
                    } else {
                        if status == .denied{
                            HImagePickerUtils.showTips(at: self,type: .takePhoto)
                        } else if status != .canceled {
                            ZXHUD.showFailure(in: self.view, text: status.description(), delay: ZX.HUDDelay)
                        }
                    }
                })
            } else if index == 1 {
                self.imagepicker.choosePhoto(presentFrom: self, completion: { (image, status) in
                    if status == .success {
                        let addNewVC = ZXAddNewPrescriptionViewController()
                        addNewVC.image = image
                        self.navigationController?.pushViewController(addNewVC, animated: true)
                    } else {
                        if status == .denied{
                            HImagePickerUtils.showTips(at: self,type: .takePhoto)
                        } else if status != .canceled {
                            ZXHUD.showFailure(in: self.view, text: status.description(), delay: ZX.HUDDelay)
                        }
                    }
                })
            }
        }
    }
    
    var showPhotoIndexPath: IndexPath?
}

extension ZXPrescriptionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            ZXAlertUtils.showActionSheet(withTitle: nil, message: nil, buttonTexts: ["查看处方原图", "删除处方"], cancelText: nil) { (index) in
                if index == 0 {
                    self.showPhotoIndexPath = indexPath
                    self.showPhoto()
                } else if index == 1 {
                    self.deletePrescription(at: indexPath.section)
                }
            }
        }
    }
    
    //MARK: - 显示处方图片
    fileprivate func showPhoto() {
        let browser = PhotoBrowser(showByViewController: self, delegate: self)
        browser.show(index: 0)
    }
    
    fileprivate func deletePrescription(at section: Int) {
        let model = self.dataList[section]
        ZXAlertUtils.showAlert(wihtTitle: nil, message: "确认删除该处方记录", buttonTexts: ["删除","取消"]) { (index) in
            if index == 0 {
                ZXHUD.showLoading(in: self.view, text: "删除中...", delay: 0)
                ZXPrescriptionViewModel.delete(model.pId, completion: { (success, errorMsg) in
                    ZXHUD.hide(for: self.view, animated: true)
                    if success {
                        self.dataList.remove(at: section)
                        self.tblList.deleteSections(IndexSet([section]), with: .automatic)
                        if self.dataList.count == 0 {
                            self.loadPrescriptionList(showHUD: false)
                        }
                    } else {
                        ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                    }
                })
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ZXPrescriptionCell.height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}

extension ZXPrescriptionViewController: PhotoBrowserDelegate {
    func photoBrowser(_ photoBrowser: PhotoBrowser, thumbnailViewForIndex index: Int) -> UIView? {
        if let indexPath = self.showPhotoIndexPath {
            return self.tblList.cellForRow(at: indexPath)
        }
        return nil
    }
    
    func photoBrowser(_ photoBrowser: PhotoBrowser, thumbnailImageForIndex index: Int) -> UIImage? {
        return UIImage.Default.empty
    }
    
    func numberOfPhotos(in photoBrowser: PhotoBrowser) -> Int {
        if showPhotoIndexPath != nil {
            return 1
        }
        return 0
    }
    
    func photoBrowser(_ photoBrowser: PhotoBrowser, rawUrlForIndex index: Int) -> URL? {
        if let indexPath = showPhotoIndexPath {
            return self.dataList[indexPath.section].zx_imageUrl
        }
        return nil
    }
}

extension ZXPrescriptionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZXPrescriptionCell.reuseIdentifier, for: indexPath) as! ZXPrescriptionCell
        cell.reloadData(model: self.dataList[indexPath.section])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
