//
//  ZXNearbyRootViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/1.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXNearbyRootViewController: ZXUIViewController {
    var modelArray: Array<Any> = []
    var modelArray_store: Array<Any> = []
    /**  百度基础地图 */
    @IBOutlet weak var mapView: BMKMapView!
    /**  底部视图 */
    @IBOutlet weak var detailView: ZXStoreDetailView!
    /**  开启定位视图 */
    @IBOutlet weak var openLocationView: UIView!
    @IBOutlet weak var openLocationViewH: NSLayoutConstraint!
    /** isLocationButtonClick：判断是否为列表页面“定位”按钮点击事件*/
    var isListVCLocationClick: Bool = false
    /** 保存用户位置*/
    var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    /** 保存是否为第一次打开百度地图*/
    var isFirstOpenMap: Bool = false
    /** 标记索引*/
    var index: Int = 0
    /** 保存上一次标记*/
    var lastAnnotation: BMKPointAnnotation = BMKPointAnnotation()
    /** 点击是否为地图空白区*/
    var isMapBlank: Bool = false
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.openLocationView.backgroundColor = UIColor.zx_colorRGB(242, 146, 82, 0.8)
        
        //
        self.addSearchView()

        // Nav
        self.addNavView()
        
        //
        self.addNotifaction()
        
        //4.判断用户定位是否可用,如果定位可用则开启百度定位服务
        self.judgmentLocationServiceEnabled()
        
        //
        self.detailView.delegate = self
        
        //加入会员成功通知
        NotificationCenter.default.addObserver(self, selector: #selector(monitorJoinMemberSuccess(_:)), name: NSNotification.Name(rawValue: ZXNotification.Member.joinSuccess), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        BMKMapView.enableCustomMapStyle(true)
        self.mapView.delegate = self
        self.locService.delegate = self
        self.locService.startUserLocationService()
        self.mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
        self.mapView.showsUserLocation = true//显示定位图层
        //设置了mapView.setRegion(region, animated: true)就不能使用viewWillAppear()
        //self.mapView.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        BMKMapView.enableCustomMapStyle(false)
        self.mapView.delegate = nil
        self.locService.delegate = self
        self.mapView.viewWillDisappear()
    }
    
    //MARK: - 加入会员成功通知
    @objc func monitorJoinMemberSuccess(_ obj: Notification){
        ZXNearbyController.joinMemberSuccess(obj) { (_ model: ZXSearchModel) in
            let arr: NSMutableArray = NSMutableArray.init(capacity: 1)
            arr.add(model)
            self.detailView.loadData(arr)
        }        
    }
    
    //MARK: - 监听定位是否开启
    func addNotifaction() {
        NotificationCenter.default.addObserver(self, selector: #selector(notifactionStatus(_:)), name: NSNotification.Name(rawValue: ZXNotification.BMap.isOpenLocation), object: nil)
    }
    
    @objc func notifactionStatus(_ info: Notification) {
        let isOpen: Bool = info.object as! Bool
        self.showTopView(isOpen)
    }
    
    //MARK: - NAV
    func addNavView() {
        self.zx_addNavBarButtonItems(textNames: ["关闭"], font: nil, color: nil, at: .left)
        self.zx_addNavBarButtonItems(textNames: ["列表"], font: nil, color: nil, at: .right)
    }
    
    override func zx_leftBarButtonAction(index: Int) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func zx_rightBarButtonAction(index: Int) {
        self.navigationController?.pushViewController(ZXNearbyStoreViewController(), animated: true)
    }
    
    //MARK: SearchView
    func addSearchView() {
        self.navigationItem.titleView = self.searchBtn
    }

    @objc func searchBtnAction() {
        self.navigationController?.pushViewController(ZXSearchViewController(), animated: false)
    }
    
    //MARK: - 判断用户定位是否可用,如果定位可用则开启百度定位服务
    func judgmentLocationServiceEnabled() {
        ZXLocationUtils.shareInstance.checkCurrentLocation { (status, location) in
            var isSuccess: Bool = false
            if status == .success {
                isSuccess = true
            }else{
                isSuccess = false
            }
            self.showTopView(isSuccess)
        }
    }
    
    //MARK: - 监听定位是否开启
    func observerLocationStatus() {
        
    }
    
    //MARK: - 判断顶部视图是否显示
    func showTopView(_ isOpen: Bool) {
        if isOpen {
            //1.开启顶部动画
            self.openTopViewAnimation(true)
            //2
            self.locService.startUserLocationService()
            //
            self.mapView.showsUserLocation = true
        }else{
            self.locService.stopUserLocationService()
            self.mapView.showsUserLocation = true
            self.openTopViewAnimation(false)
            
            //默认位置为公司
            let userLo = CLLocationCoordinate2DMake(ZX.Location.latitude, ZX.Location.longitude)
            
            self.userLocation = userLo
            
            self.requestForPharmacyList()
        }
        //4.定位中心点
        self.setUserLocation()
    }
    
    //MARK: - 开启顶部视图动画
    func openTopViewAnimation(_ isOpen: Bool) {
        if isOpen {
            self.openLocationView.isHidden = true
            self.openLocationViewH.constant = 0
        }else{
            self.openLocationViewH.constant = 64
            self.openLocationView.isHidden = false
        }
    }
    
    //MARK: - 定位中心点
    func setUserLocation() {
        ZXLocationUtils.shareInstance.checkCurrentLocation { (status, location) in
            if status == .success {
                //1.获取用户位置
                let center = CLLocationCoordinate2DMake((location?.coordinate.latitude)!, (location?.coordinate.longitude)!)
                
                //设置地图中心点
                self.setUserCenter(center)
            }
        }
    }
    
    //MARK:- 设置地图中心点
    func setUserCenter(_ center: CLLocationCoordinate2D) {
        //2.指定经纬度的跨度(跨度越小,显示越详细)
        var span: BMKCoordinateSpan = BMKCoordinateSpan()
        span.latitudeDelta = 0.05
        span.longitudeDelta = 0.05
        //3.将用户当前位置作为显示区域的中心点,并且指定需要显示的跨度范围
        var region: BMKCoordinateRegion = BMKCoordinateRegion()
        region.center = center
        region.span = span
        //4.设置显示区域
        mapView.setRegion(region, animated: false)
    }
    
    //MARK: - 开启定位
    @IBAction func openLocationAction(_ sender: UIButton) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL.init(string: UIApplicationOpenSettingsURLString)!, options: [UIApplicationOpenURLOptionUniversalLinksOnly:""]) { (succ) in
            }
        } else {
            UIApplication.shared.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
        }
    }
    
    //MARK: - 刷新底部视图/定位(列表点击定位)
    func loadDataForDetailView(_ array: Array<ZXSearchModel>) {
        self.modelArray = array
        
        self.selectedAnnotation(array)
    }
    
    deinit {
        print("__func__")
        if mapView != nil {
            locService.stopUserLocationService()
            mapView.showsUserLocation = false
            mapView.delegate = nil
            locService.delegate = nil
            mapView = nil
            openLocationView = nil
            detailView.delegate = nil
            detailView = nil
            index = 0
            isFirstOpenMap = false
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Lazy
    lazy var searchBtn: UIButton = {
        let btn: UIButton = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 0, y: 0, width: 290, height: 30)
        btn.backgroundColor = UIColor.white
        btn.setImage(#imageLiteral(resourceName: "icon-search"), for: .normal)
        btn.setTitle(" 搜索药店、医馆", for: .normal)
        btn.setTitleColor(UIColor.zx_textColorMark, for: .normal)
        btn.titleLabel?.font = UIFont.zx_bodyFont(UIFont.zx_bodyFontSize - 2)
        btn.layer.cornerRadius = 5.0
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(searchBtnAction), for: .touchUpInside)
        return btn
    }()
    
    func setMapView() {
        self.mapView.delegate = self
        self.mapView.userTrackingMode = BMKUserTrackingModeNone;
        self.mapView.mapType = UInt(BMKMapTypeStandard);
        self.mapView.isZoomEnabled = true;
        self.mapView.isScrollEnabled = true;
        self.mapView.showsUserLocation = true;//显示定位图层
    }
    
    /**  百度定位服务 */
    lazy var locService: BMKLocationService = {
        var service: BMKLocationService = BMKLocationService()
        service.delegate = self
        return service
    }()
    
    lazy var  dataModelArray: NSMutableArray = {
        let arr: NSMutableArray = NSMutableArray.init(capacity: 10)
        return arr
    }()
}

