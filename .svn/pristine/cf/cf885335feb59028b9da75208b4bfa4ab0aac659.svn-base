//
//  ZXDrugRemindRootViewController+Table.swift
//  YDHYK
//
//  Created by 120v on 2017/11/24.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

extension ZXDrugRemindRootViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ZXRemindListRootCell = tableView.dequeueReusableCell(withIdentifier: ZXRemindListRootCell.ZXRemindListRootCellID, for: indexPath) as! ZXRemindListRootCell
        cell.delegate = self
        if self.remindArr.count > 0,self.isNoData == false {
            cell.loadData(self.remindArr[indexPath.row] as! ZXRemindModel)
        }else if self.remindArr.count == 5,self.isNoData == true {
            cell.remindSwicher.isHidden = true
            cell.remindSwicher.clipsToBounds = true
            cell.nameLb.text = ""
            cell.descLb.text = ""
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.remindArr.count == 5,self.isNoData == true {
            return 1
        }else if self.remindArr.count == 0 , self.isNoData == true{
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.remindArr.count == 5,self.isNoData == true {
            return 5
        }else{
            return self.remindArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}


extension ZXDrugRemindRootViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ZXAlertUtils.showAlert(wihtTitle: "", message: "确认删除提醒？", buttonTexts: ["取消","确定"], action: { (index) in
                if index == 1 {
                    if self.remindArr.count > 0 {
                        let model = self.remindArr[indexPath.row]
                        //删除
                        self.requestForDeletedRemind(model as! ZXRemindModel,indexPath,tableView)
                    }
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
}

extension ZXDrugRemindRootViewController: ZXRemindListRootCellDelegate {
    func didListRootCellSwich(_ sender: UISwitch, _ model: ZXRemindModel?) {
        var push: Int = 0
        if sender.isOn {
            push = 1
        }
        self.requestForPushStatus(push, model)
    }
}
