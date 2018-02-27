//
//  ZXOrderListViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/6.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

/// 用户订单列表
class ZXOrderListViewController: ZXUIViewController, ZXUCOrderControlActionDelegate {
    
    @IBOutlet weak var tblList: UITableView!
    
    var orderStatus: ZXUCOrderStatus = .all
    var receiveType: ZXUCOrderReceivingType = .all
    var currentPage: Int = 1
    var orderList: Array<ZXUCOrderDetailModel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = orderStatus.description()
        self.tblList.backgroundColor = UIColor.zx_subTintColor
        
        self.tblList.register(UINib.init(nibName: ZXUCOderStoreCell.NibName, bundle: nil), forCellReuseIdentifier: ZXUCOderStoreCell.reuseIdentifier)
        self.tblList.register(UINib.init(nibName: ZXUCOrderDrugCell.NibName, bundle: nil), forCellReuseIdentifier: ZXUCOrderDrugCell.reuseIdentifier)
        self.tblList.register(UINib.init(nibName: ZXUCOrderControlFooterCell.NibName, bundle: nil), forCellReuseIdentifier: ZXUCOrderControlFooterCell.reuseIdentifier)
        self.tblList.register(UINib.init(nibName: ZXUCOrderNoneControlFooterCell.NibName, bundle: nil), forCellReuseIdentifier: ZXUCOrderNoneControlFooterCell.reuseIdentifier)
        self.tblList.zx_addHeaderRefresh(showGif: true, target: self, action: #selector(zx_refresh))
        self.tblList.zx_addFooterRefresh(autoRefresh: true, target: self, action: #selector(zx_loadmore))
        self.tblList.mj_header.beginRefreshing()
        
        self.loadOrderStatusUpdateNotice()
    }
    
    override func zx_refresh() {
        currentPage = 1
         self.loadOrderList(false)
    }
    
    override func zx_loadmore() {
        currentPage += 1
        self.loadOrderList(false)
    }
    
    //MARK: -
    func loadOrderList(_ showHUD: Bool) {
        if showHUD {
            ZXHUD.showText(in: self.view, text: ZX_LOADING_TEXT, delay: ZX.HUDDelay)
        }
        ZXUCOrderViewModel.orderList(pageNum: currentPage, pageSize: ZX.PageSize, status: orderStatus, type: receiveType) { (success, code, list, errorMsg) in
            ZXHUD.hide(for: self.view, animated: true)
            ZXEmptyView.hide(from: self.tblList)
            ZXEmptyView.hide(from: self.view)
            self.tblList.mj_header.endRefreshing()
            self.tblList.mj_footer.endRefreshing()
            if success {
                if let list = list {
                    if self.currentPage == 1 {
                        self.orderList = list
                    } else {
                        self.orderList.append(contentsOf: list)
                    }
                    if self.orderList.count < ZX.PageSize {
                        self.tblList.mj_footer.endRefreshingWithNoMoreData()
                    }
                    self.tblList.reloadData()
                }
                if self.orderList.count == 0 {
                    ZXEmptyView.show(in: self.tblList, type: .noData, text: "暂无订单数据")
                }
            } else {
                if code != ZXAPI_LOGIN_INVALID {
                    if self.orderList.count > 0 {//之前有数据，再次获取时网络出错
                        if code == ZXAPI_HTTP_TIME_OUT {
                            ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                        } else {
                            ZXHUD.showFailure(in: self.view, text: "此时无法访问服务器", delay: ZX.HUDDelay)
                        }
                    } else {//第一次获取数据就出错 详细网络连接错误
                        if code == ZXAPI_HTTP_ERROR {
                            ZXEmptyView.show(in: self.view, type: .networkError, text: nil, retry: {
                                self.loadOrderList(true)
                            })
                        } else {
                            ZXEmptyView.show(in: self.tblList, type: .noData, text: "暂无订单数据")
                            ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                        }
                    }
                } else {
                    if self.orderList.count == 0 {
                        ZXEmptyView.show(in: self.tblList, type: .noData, text: "暂无订单数据")
                    }
                }
            }
        }
    }
    
    //MARK: - 订单操作
    func zxUCOrderControlerAction(with type: ZXOrderControlType, cell: UITableViewCell) {
        if let indexPath = self.tblList.indexPath(for: cell) {
            let model = orderList[indexPath.section]
            switch type {
            case .toPay:
                print("支付")
            case .reviewCode://查看提货码
                let reviewPickupCodeVC = ZXReviewPickupCodeViewController()
                reviewPickupCodeVC.orderId = model.orderId
                self.navigationController?.pushViewController(reviewPickupCodeVC, animated: true)
            case .confirmSign://确认收货
                self.changeOrderStatus(to: .finished, orderId: model.orderId,section: indexPath.section)
            case .cancel://取消订单
                self.changeOrderStatus(to: .canceled, orderId: model.orderId,section: indexPath.section)
            case .delete://删除订单 置为无效
                self.changeOrderStatus(to: .invalid, orderId: model.orderId,section: indexPath.section)
            default:
                break
            }
        }
    }
    
    fileprivate func changeOrderStatus(to status: ZXUCOrderStatus,orderId: String,section: Int) {
        var controlTitle = "订单操作..."
        var buttons = ["放弃","确定"]
        switch status {
            case .invalid:
                controlTitle = "确定删除订单?"
                buttons = ["放弃","确定"]
            case .canceled:
                controlTitle = "确定取消订单?"
                buttons = ["放弃","确定"]
            case .finished:
                controlTitle = "请确保已经收到您的物品?"
                buttons = ["稍后","确定"]
            default:
                break
        }
        if status == .invalid || status == .canceled || status == .finished {
            ZXAlertUtils.showActionSheet(withTitle: "提示", message: controlTitle, buttonTexts: buttons, cancelText: nil) { (index) in
                if index == 1 {
                    ZXHUD.showLoading(in: self.view, text: "操作中", delay: 0)
                    ZXUCOrderViewModel.changeOrder(orderId, to: status, completion: { (success, code, errorMsg) in
                        ZXHUD.hide(for: self.view, animated: true)
                        if success {
                            if self.orderStatus == .all,status != .invalid {
                                //全部订单操作（取消、完成不删除） 还会显示在当前界面
                                self.zx_refresh()
                                ZXHUD.showSuccess(in: self.view, text: "订单操作成功", delay: ZX.HUDDelay)
                            } else {
                                self.orderList.remove(at: section)
                                self.tblList.deleteSections(IndexSet([section]), with: .automatic)
                                if self.orderList.count == 0 {
                                    self.zx_refresh()
                                }
                            }
                        } else {
                            if code != ZXAPI_LOGIN_INVALID {
                                ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                            }
                        }
                    })
                }
            }
        }
    }
}

extension ZXOrderListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.orderList[indexPath.section]
        let count = model.orderDetailList.count
        if indexPath.row == 0 { //店铺
            let storeVC = ZXStoreRootViewController.configVC(storeId: model.drugstoreId, memberId: ZXUser.user.memberId, token: ZXUser.user.userToken)
            self.navigationController?.pushViewController(storeVC, animated: true)
        } else if indexPath.row <= count { //统一到订单详情
            let orderDetail = ZXUCOrderDetailViewController()
            orderDetail.orderId = model.orderId
            self.navigationController?.pushViewController(orderDetail, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = orderList[indexPath.section]
        if indexPath.row == 0 {//第一行店铺
            return ZXUCOderStoreCell.height
        } else if indexPath.row == model.orderDetailList.count + 1{//最后一行操作 总价、操作
            return ZXUCOrderControlFooterCell.height
        }
        return ZXUCOrderDrugCell.height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

extension ZXOrderListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.orderList[indexPath.section]
        let count = model.orderDetailList.count
        switch indexPath.row {
        case 0://店铺
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXUCOderStoreCell.reuseIdentifier, for: indexPath) as! ZXUCOderStoreCell
            cell.reloadData(model: model)
            return cell
        case count + 1://总金额、操作按钮
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXUCOrderControlFooterCell.reuseIdentifier, for: indexPath) as! ZXUCOrderControlFooterCell
            cell.delegate = self
            cell.reloadData(model: model)
            return cell
        default://商品
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXUCOrderDrugCell.reuseIdentifier, for: indexPath) as! ZXUCOrderDrugCell
            cell.reloadData(model: model.orderDetailList[indexPath.row - 1])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = self.orderList[section]
        if model.orderDetailList.count > 0{
            return 1 + model.orderDetailList.count + 1//店铺 - 药品 - 总价格/操作按钮
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.orderList.count
    }
}
