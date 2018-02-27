//
//  ZXSystemMessageDetailViewController.swift
//  YDHYK
//
//  Created by screson on 2017/11/10.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXSystemMessageDetailViewController: ZXUIViewController,UIWebViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var webContent: UIWebView!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var loadingHUD: UIActivityIndicatorView!
    @IBOutlet weak var contentWidth: NSLayoutConstraint!
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    @IBOutlet weak var webViewHeight: NSLayoutConstraint!
    
    var messageModel: ZXMessageDetailModel?
    
    var messageId: String?
    var type: Int = 1 //1：现金券 2：促销活动
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "消息详情"
        // Do any additional setup after loading the view.
        
        self.scrollView.backgroundColor = .white
        self.webContent.backgroundColor = .white
        
        self.lbTitle.font = UIFont.zx_titleFont
        self.lbTitle.textColor = UIColor.zx_textColorTitle
        
        self.lbDate.font = UIFont.zx_titleFont(13)
        self.lbDate.textColor = UIColor.zx_textColorMark
        self.lbDate.isHidden = true
        
        self.loadingHUD.hidesWhenStopped = true
        self.webContent.delegate = self
        self.webContent.scrollView.isScrollEnabled = false
        self.webContent.stringByEvaluatingJavaScript(from: "document.documentElement.style.webkitUserSelect='none';")
        self.webContent.stringByEvaluatingJavaScript(from: "document.documentElement.style.webkitTouchCallout='none';")
        if #available(iOS 11.0, *) {
            self.scrollView.contentInsetAdjustmentBehavior = .never
            self.webContent.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = false
            self.edgesForExtendedLayout = []
        }
        self.scrollView.alwaysBounceVertical = true
        webViewHeight.constant = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !onceLoad {
            onceLoad = true
            self.loadMessageDetail()
        }
    }
    
    func loadMessageDetail() {
        if let messageId = messageId {
            ZXSysMessageViewModel.detail(with: messageId, type: "\(type)") { (success, model, errorMsg) in
                if success {
                    self.messageModel = model
                    self.reloadUI()
                } else {
                    ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                }
            }
        } else {
            ZXHUD.showFailure(in: self.view, text: "消息ID不存在", delay: ZX.HUDDelay)
        }
    }
    
    fileprivate func reloadUI() {
        if let model = self.messageModel {
            self.lbTitle.text = model.title
            self.lbDate.text = model.sendDateStr
            self.webContent.loadHTMLString(model.zx_content, baseURL: nil)
        }
    }
    
    fileprivate func updateFrame() {
        contentWidth.constant = ZXBOUNDS_WIDTH
        let htmlHeight = self.webContent.scrollView.contentSize.height 
        webViewHeight.constant = htmlHeight
        self.view.layoutIfNeeded()
        var totalHeight = self.lbDate.frame.maxY + 20
        //var totalHeight = htmlHeight + 20
        if totalHeight < ZXBOUNDS_HEIGHT - 64 {
            totalHeight = ZXBOUNDS_HEIGHT - 64
        }
        contentHeight.constant = totalHeight
        self.scrollView.contentSize = CGSize(width: ZXBOUNDS_WIDTH, height: totalHeight)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.updateFrame()
    }
    
    //MARK: -
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.loadingHUD.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.loadingHUD.stopAnimating()
        self.updateFrame()
        self.lbDate.isHidden = false
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.loadingHUD.stopAnimating()
    }
    
}
