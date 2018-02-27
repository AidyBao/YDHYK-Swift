//
//  ZXAddNewReport+InputAction.swift
//  YDHYK
//
//  Created by screson on 2017/11/24.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

extension ZXAddNewReportAnalyseViewController: ZXItemInputCellDelegate {
    func zxItemInputCellDeleteAction(cell: ZXItemInputCell) {
        if let indexPath = self.tblReportItem.indexPath(for: cell) {
            ZXAlertUtils.showAlert(wihtTitle: nil, message: "确定删除该条检查项?", buttonTexts: ["删除", "取消"], action: { (index) in
                if index == 0 {
                    self.addedItemList.remove(at: indexPath.row)
                    self.tblReportItem.deleteRows(at: [indexPath], with: .automatic)
                }
            })
        }
    }
}

extension ZXAddNewReportAnalyseViewController: ZXAgeSexInputCellDelegate {
    func zxAgeSexIntpuCell(cell: ZXAgeSexInputCell, sexSelected index: Int, text: String?) {
        self.sexStr = text
    }
    
    func zxAgeSexIntpuCell(cell: ZXAgeSexInputCell, agevalueChanged age: String?) {
        self.ageStr = age
    }
    
}
