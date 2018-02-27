//
//  ZXSettingTimeView.swift
//  YDHYK
//
//  Created by 120v on 2017/11/24.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

typealias ZXSettingTimeCompletion = (_ arry: Array<ZXAddTimeModel>) -> Void

class ZXSettingTimeView: UIView {

    var completion: ZXSettingTimeCompletion?
    let space: CGFloat = 14.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUI()
    }
    
    func setUI() {
        self.backgroundColor = UIColor.white
        self.collectionView.backgroundColor = UIColor.white
        self.addSubview(self.collectionView)
        self.collectionView.register(UINib.init(nibName: String.init(describing: ZXSettingTimeCell.self), bundle: nil), forCellWithReuseIdentifier: ZXSettingTimeCell.ZXSettingTimeCellID)
        self.collectionView.register(UINib.init(nibName: String.init(describing: ZXAddTimeCell.self), bundle: nil), forCellWithReuseIdentifier: ZXAddTimeCell.ZXAddTimeCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.collectionView.size = CGSize.init(width: self.frame.size.width, height: self.frame.size.height)
    }
    
    //MARK: - Lazy
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.minimumInteritemSpacing = 14
        layout.minimumLineSpacing = 14
        let collView: UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 125), collectionViewLayout: layout)
        collView.showsVerticalScrollIndicator = false
        collView.showsHorizontalScrollIndicator = false
        collView.delegate = self
        collView.dataSource = self
        return collView
    }()
    
    lazy var dateSource: NSMutableArray = {
        let arr: NSMutableArray = NSMutableArray.init(object: "点击添加")
        return arr
    }()
    
    lazy var tempDateArray: NSMutableArray = {
        let arr: NSMutableArray = NSMutableArray.init(capacity: 5)
        return arr
    }()
    
}

extension ZXSettingTimeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //1.判断设置是否达上限
        if self.dateSource.count >= 6,indexPath.row == self.dateSource.count - 1 {
            ZXHUD.showFailure(in: ZXRootController.appWindow()!, text: "设置已达上限", delay: ZX.HUDDelay)
            return
        }
        
        //2.时间视图
        let dateView: ZXDataView = ZXDataView.loadNib()
        ZXRootController.appWindow()?.addSubview(dateView)

        //1.1 判断设置个数
        if indexPath.row == self.dateSource.count - 1 {//新增
            if self.dateSource.count >= 6 {
                ZXHUD.showFailure(in: ZXRootController.appWindow()!, text: "设置已达上限", delay: ZX.HUDDelay)
            }else{
                dateView.completion = {dateStr,sender,dateModel in
                    //新增
                    self.addTime(dateView, dateStr, sender, indexPath)

                    //移除视图
                    dateView.removeFromSuperview()
                }
            }
        }else{//修改，删除
            //1.取值
            var model: ZXAddTimeModel?
            if self.dateSource.count > 0 {
                model = self.dateSource.object(at: indexPath.row) as? ZXAddTimeModel
            }
            
            //2.设置默认时间
            dateView.loadDateUIWithType(.Delete, "修改用药时间", "删除", model)
            
            //3.回调
            dateView.completion = {dateStr,sender,dateModel in
                if sender.titleLabel?.text == "确定" {//4.修改时间
                    //修改时间
                    self.modifyTime(dateView, dateStr, sender, indexPath)
                    
                }else if sender.titleLabel?.text == "删除" {//5.删除时间
                    //删除时间
                    self.delete(indexPath,model)
                }
                
                //6.刷新及回调
                self.loadData()

                //7.移除视图
                dateView.removeFromSuperview()
            }
        }
    }
    
    //MARK: - 新增时间
    func addTime(_ dateView: ZXDataView,_ dateStr: String,_ sender:UIButton,_ indexPath: IndexPath){
        //1 查找相同设置
        for str in self.tempDateArray {
            if let str = str as? String,dateStr == str {
                self.tempDateArray.remove(str)
                ZXHUD.showFailure(in: ZXRootController.appWindow()!, text: "已经设置过了", delay: ZX.HUDDelay)
                dateView.removeFromSuperview()
                return
            }
        }
        //2 添加
        self.tempDateArray.add(dateStr)
        
        //3 新增和修改时间
        self.addAndModifyTimeForcommon(self.tempDateArray as! Array<String>)
        
        //4 刷新/传值
        self.loadData()
    }
    
    //MARK: - 修改时间
    func modifyTime(_ dateView: ZXDataView,_ dateStr: String,_ sender:UIButton,_ indexPath: IndexPath){
        //1 判断是否有相同时间
        for model in self.dateSource {
            if let model = model as? ZXAddTimeModel,dateStr == model.drugTime {
                ZXHUD.showFailure(in: ZXRootController.appWindow()!, text: "已经设置过了", delay: ZX.HUDDelay)
                dateView.removeFromSuperview()
                return
            }
        }
        //2 修改时间
        let model: ZXAddTimeModel = self.dateSource.object(at: indexPath.row) as! ZXAddTimeModel
        model.drugTime = dateStr
        
        self.tempDateArray.replaceObject(at: indexPath.row, with: model.drugTime)
        
        //3 从dataArray取出放入temArray
        let arr: NSMutableArray = NSMutableArray.init(capacity: 5)
        for model in self.dateSource {
            if let model = model as? ZXAddTimeModel {
                arr.add(model.drugTime)
            }
        }
        
        //4 公共方法
        self.addAndModifyTimeForcommon(arr as! Array<String>)
    }
    
    //Mark: - 删除
    func delete(_ index: IndexPath,_ model: ZXAddTimeModel?){
        let index: Int = Int((model?.addQty)!)! - 1
        //1 移除
        self.dateSource.removeObject(at: index)
        self.tempDateArray.removeObject(at: index)
        
        //2 更新次数
        for (idx,model) in self.dateSource.enumerated() {
            if let model = model as? ZXAddTimeModel {
                model.addQty = "\(idx + 1)"
            }
        }
    }
    
    //MARK: - 刷新/回调
    func loadData() {
        //1.刷新
        self.collectionView.reloadData()
        
        //2.传值
        if self.completion != nil {
            let tArr: Array<ZXAddTimeModel> = self.dateSource.subarray(with: NSRange.init(location: 0, length: self.dateSource.count - 1)) as! Array<ZXAddTimeModel>
            self.completion?(tArr)
        }
    }
    
    //MARK: - 添加/修改用药时间公共方法
    func addAndModifyTimeForcommon(_ array: Array<String>){
        //1. 排序
        let arr = array.sorted { (dateStr1, dateStr2) -> Bool in
            return dateStr2 > dateStr1
        }
        
        //2. 除最后一条数据其他全部移除
        if self.dateSource.count > 0 {
            self.dateSource.removeObjects(in: NSMakeRange(0, self.dateSource.count - 1))
        }
        
        //3. 从temArray添加dataArray
        for (idx,str) in arr.enumerated() {
            let model = ZXAddTimeModel.setTimeModel(str, "\(idx+1)")
            self.dateSource.insert(model, at: self.dateSource.count - 1)
        }
    }
}

extension ZXSettingTimeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dateSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == self.dateSource.count - 1 {
            let cell: ZXAddTimeCell = collectionView.dequeueReusableCell(withReuseIdentifier: ZXAddTimeCell.ZXAddTimeCellID, for: indexPath) as! ZXAddTimeCell
            return cell
        }else{
            let cell: ZXSettingTimeCell = collectionView.dequeueReusableCell(withReuseIdentifier: ZXSettingTimeCell.ZXSettingTimeCellID, for: indexPath) as! ZXSettingTimeCell
            if self.dateSource.count > 0 {
                cell.loadData(self.dateSource.object(at: indexPath.row) as! ZXAddTimeModel)
            }
            return cell
        }
    }
}

extension ZXSettingTimeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let conW: CGFloat = (ZXBOUNDS_WIDTH - 4 * self.space)/3
        let conH: CGFloat = conW * 0.67
        return CGSize.init(width: conW, height: conH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: self.space, bottom: self.space, right: self.space)
    }
}

