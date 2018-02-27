//
//  ZXDiscoverVC+Table.swift
//  YDHYK
//
//  Created by screson on 2017/11/3.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

extension ZXDiscoverRootViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let detailVC = ZXDiscoverDetailViewController()
            detailVC.model = self.arrDiscoverList[indexPath.section]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.arrDiscoverList[indexPath.section]
        if model.homeIconType == 1 {
            return 110
        }
        return 240
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        } else {
            let preModel = arrDiscoverList[section - 1]
            let model = arrDiscoverList[section]
            if model.homeIconType != preModel.homeIconType {//上下两张不一样
                return 10
            } else {//上下两张一样 并且是大图 间隔10
                if preModel.homeIconType != 1 {
                    return 10
                }
            }
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tblList.dequeueReusableHeaderFooterView(withIdentifier: ZXEmptyHeader.reuseIdentifier)
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tblList.dequeueReusableHeaderFooterView(withIdentifier: ZXEmptyHeader.reuseIdentifier)
        return view
    }
}

extension ZXDiscoverRootViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.arrDiscoverList[indexPath.section]
        if model.homeIconType == 1 {
            let cell = tblList.dequeueReusableCell(withIdentifier: ZXDiscoverSamllTypeCell.reuseIdentifier, for: indexPath) as! ZXDiscoverSamllTypeCell
            cell.reloadData(model: model)
            return cell
        } else {
            let cell = tblList.dequeueReusableCell(withIdentifier: ZXDiscoverBigTypeCell.reuseIdentifier, for: indexPath) as! ZXDiscoverBigTypeCell
            cell.reloadData(model: model)
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrDiscoverList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
