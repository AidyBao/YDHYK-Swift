//
//  ZXHistoryOrderController.swift
//  YDHYK
//
//  Created by 120v on 2017/11/28.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

protocol ZXHistoryOrderControllerDelegate: NSObjectProtocol {
    func didHistoryOrderCell(_ model: ZXHistoryOrderDetailModel) -> Void
}
class ZXHistoryOrderController: ZXUIViewController {
    
    weak var delegate: ZXHistoryOrderControllerDelegate?
    @IBOutlet weak var tableView: UITableView!    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "从我的订单中添加"
        
        self.tableView.backgroundColor = UIColor.zx_subTintColor
        self.tableView.register(UINib.init(nibName: String.init(describing: ZXHistoryOrderCell.self), bundle: nil), forCellReuseIdentifier: ZXHistoryOrderCell.ZXHistoryOrderCellID)
        
        //
        self.getDetailOrderData()
    }
    
    //MARK: - 取值
    func getDetailOrderData() {
        ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: ZX.HUDDelay)
        if self.histOrderArray.count == 0 {
            ZXEmptyView.show(in: self.view, type: .noData, text: "没有数据")
        }else{
            ZXHUD.hide(for: self.view, animated: true)
            ZXEmptyView.hide(from: self.view)
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - Lazy
    lazy var histOrderArray: Array<ZXHistoryOrderModel> = {
        let arr: Array<ZXHistoryOrderModel> = Array.init()
        return arr
    }()

    lazy var detailArray: Array<ZXHistoryOrderDetailModel> = {
        let arr: Array<ZXHistoryOrderDetailModel> = Array.init()
        return arr
    }()
    
}


// MARK: - Table view data source
extension ZXHistoryOrderController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.histOrderArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.histOrderArray.count > 0 {
            let hisOrderModel = self.histOrderArray[section]
            let orderDetailArr = hisOrderModel.orderDetailList
            if orderDetailArr.count > 0 {
                return orderDetailArr.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ZXHistoryOrderCell = tableView.dequeueReusableCell(withIdentifier: ZXHistoryOrderCell.ZXHistoryOrderCellID, for: indexPath) as! ZXHistoryOrderCell
        if self.histOrderArray.count > 0 {
            let hisOrderModel = self.histOrderArray[indexPath.section]
            let orderDetailArr = hisOrderModel.orderDetailList
            if orderDetailArr.count > 0 {
                let detailModel = orderDetailArr[indexPath.row]
                cell.loadData(detailModel as! ZXHistoryOrderDetailModel)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

//MARK: - UITableViewDelegate
extension ZXHistoryOrderController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newCell:ZXHistoryOrderCell = tableView.cellForRow(at: indexPath) as! ZXHistoryOrderCell
        if newCell.accessoryType == .none {
            newCell.accessoryType = .checkmark
            newCell.nameLb.textColor = UIColor.zx_subTintColor
        }else{
            newCell.accessoryType = .none
            newCell.nameLb.textColor = UIColor.zx_textColorBody
        }
        
        if self.histOrderArray.count > 0 {
            let hisOrderModel = self.histOrderArray[indexPath.section]
            let orderDetailArr = hisOrderModel.orderDetailList
            if orderDetailArr.count > 0 {
                let detailModel = orderDetailArr[indexPath.row]
                if delegate != nil {
                    delegate?.didHistoryOrderCell(detailModel as! ZXHistoryOrderDetailModel)
                }
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let oldCell:ZXHistoryOrderCell = tableView.cellForRow(at: indexPath) as! ZXHistoryOrderCell
        if oldCell.accessoryType == .checkmark {
            oldCell.accessoryType = .none
            oldCell.nameLb.textColor = UIColor.zx_textColorBody
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ZXBOUNDS_WIDTH, height: 44))
        headerView.backgroundColor = UIColor.zx_subTintColor
        
        let title: UILabel = UILabel.init(frame: CGRect.init(x: 14, y: 0, width: ZXBOUNDS_WIDTH - 2*14, height: 44))
        title.textColor = UIColor.zx_textColorMark
        title.font = UIFont.zx_titleFont
        headerView.addSubview(title)
        
        if self.histOrderArray.count > 0 {
            let orderModel = self.histOrderArray[section]
            
            let startIdx = orderModel.orderDateStr.index(orderModel.orderDateStr.startIndex, offsetBy: 5)
            let endIdx = orderModel.orderDateStr.index(orderModel.orderDateStr.startIndex, offsetBy: 10)
            let dataStr = orderModel.orderDateStr.substring(with: startIdx..<endIdx)
            title.text = "\(dataStr) \(orderModel.drugstoreName)"
        }
        return headerView
    }
}

