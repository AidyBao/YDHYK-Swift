//
//  ZXDrugDetailView.swift
//  YDHYK
//
//  Created by 120v on 2017/11/23.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXDrugDetailView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nowBtn: ZXUIButton!
    @IBOutlet weak var laterBtn: ZXUIButton!
    @IBOutlet weak var deletedBtn: UIButton!
    
    var drugTime: String = ""
    
    static func loadNib() -> ZXDrugDetailView{
        let nibView:ZXDrugDetailView = Bundle.main.loadNibNamed("ZXDrugDetailView", owner: self, options: nil)?.first as! ZXDrugDetailView
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
        //
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        //
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.layer.cornerRadius = 5.0
        self.tableView.layer.masksToBounds = true
        self.tableView.register(UINib.init(nibName: String.init(describing: ZXDrugDetailCell.self), bundle: nil), forCellReuseIdentifier: ZXDrugDetailCell.ZXDrugDetailCellID)
        //
        self.nowBtn.backgroundColor = UIColor.white
        self.nowBtn.titleLabel?.font = UIFont.zx_titleFont
        self.nowBtn.setTitleColor(UIColor.zx_tintColor, for: .normal)
        
        //
        self.laterBtn.backgroundColor = UIColor.darkGray
        self.laterBtn.titleLabel?.font = UIFont.zx_titleFont
        self.laterBtn.setTitleColor(UIColor.white, for: .normal)
    }
    
    //MARK: - LoadData
    func loadData(_ dict: Dictionary<String,Any>,_ isTakeDrug:Bool) {
        
        if !isTakeDrug {//服药提醒
            self.nowBtn.isHidden = false
            self.laterBtn.isHidden = false
            self.deletedBtn.isHidden = true
        }else{
            self.nowBtn.isHidden = true
            self.laterBtn.isHidden = true
            self.deletedBtn.isHidden = false
        }
        
        self.dataSource.removeAll()
        
        let key: String = dict.keys.first!
        let arr: Array<Any> = dict[key] as! Array<Any>
        self.dataSource = arr
        
        self.drugTime = key
        
        self.tableView.reloadData()
    }
    
    //MARK: - 现在服药
    @IBAction func nowBtnAction(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    //MARK: - 稍后服药
    @IBAction func laterBtnAction(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    //MARK: - 删除
    @IBAction func deletedBtnAction(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.removeFromSuperview()
    }
    
    //MARK: - Lazy
    lazy var dataSource: Array<Any> = {
        let array: Array<Any> = Array.init()
        return array
    }()
    
}

extension ZXDrugDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.tableView.width, height: 60))
        headerView.backgroundColor = UIColor.white
        
        //时间
        let timeLabel: UILabel = UILabel.init(frame: CGRect.init(x: 10, y: 10, width: 100, height: 40))
        timeLabel.text = self.drugTime
        timeLabel.font = UIFont.systemFont(ofSize: 34.0)
        timeLabel.textColor = UIColor.zx_tintColor
        headerView.addSubview(timeLabel)
        
        //需要服用的yaop
        let titleLable:UILabel = UILabel.init()
        titleLable.text = "需要服用的药品"
        titleLable.x = timeLabel.frame.maxX
        titleLable.width = 120
        titleLable.height = 30
        titleLable.y = headerView.height - titleLable.height - 10;
        titleLable.font = UIFont.zx_markFont
        titleLable.textColor = UIColor.zx_tintColor
        headerView.addSubview(titleLable)
        
        //隔离线
        let geliView: UIView = UIView.init()
        geliView.x = 0
        geliView.height = 1
        geliView.width = headerView.width
        geliView.y = headerView.height - geliView.height
        geliView.backgroundColor = UIColor.groupTableViewBackground
        headerView.addSubview(geliView)
        
        return headerView
    }
}

extension ZXDrugDetailView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ZXDrugDetailCell = tableView.dequeueReusableCell(withIdentifier: ZXDrugDetailCell.ZXDrugDetailCellID, for: indexPath) as! ZXDrugDetailCell
        if self.dataSource.count > 0 {
            cell.loadData(self.dataSource[indexPath.row] as! ZXRemindModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 28.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}