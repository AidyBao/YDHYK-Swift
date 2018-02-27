//
//  ZXDiscover+Scroll\.swift
//  YDHYK
//
//  Created by screson on 2017/11/3.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

// MARK: - 控制滑动时 菜单隐藏/显示
extension ZXDiscoverRootViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        oldOffsetY = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        newOffsetY = scrollView.contentOffset.y
        if (newOffsetY - oldOffsetY) > 0 {
            direction = .up
        }else{
            direction = .down
        }
        if (!decelerate) {//tableView不需要自动回滚
            startTrackingScroll = false
            self.endDragAcion()
        } else {//tableView自动回滚
            startTrackingScroll = true
            isDecelerating = true
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.endDragAcion()
        isDecelerating = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !startTrackingScroll {
            //记录offsetY及Direction不做处理
            currentOffsetY = scrollView.contentOffset.y
            return
        }
        if scrollView.contentOffset.y <= -140 {
            self.tblList.mj_header?.isHidden = false
        } else {
            self.tblList.mj_header?.isHidden = true
        }
        var value = fabs(scrollView.contentOffset.y) / 100
        value = value >= 1 ? 1 : value
        value = value <= 0 ? 0 :value
        
        if scrollView.contentOffset.y > 0 {
            value = 0
        }
        
        self.topMenuContentView.isHidden = false
        ccvTopMenu.alpha = value
        self.setNavBarAlpha(1 - value)
        ccvTopOffset.constant = -(1 - value) * 50
        currentOffsetY = scrollView.contentOffset.y;
    }
    //MARK: - 滚动显相关
    
    func isNeedHideCCVMenuView() -> Bool { //如果一屏能够放下所有内容 不关闭大工具栏
        if (self.tblList.frame.size.height - self.tblList.contentSize.height) >= 100 {
            return false
        }
        return true
    }
    
    func setNavbarMenu(hidden: Bool) {
        self.leftMenuView.isHidden = hidden
        self.rightMenuView.isHidden = hidden
    }
    
    func setNavBarAlpha(_ alpha: CGFloat) {
        if alpha <= 0 {
            self.setNavbarMenu(hidden: true)
        } else {
            self.setNavbarMenu(hidden: false)
        }
        self.leftMenuView.alpha = alpha
        self.rightMenuView.alpha = alpha
    }
    
    func endDragAcion() {
        currentOffsetY = self.tblList.contentOffset.y
        if isNeedHideCCVMenuView() {
            if direction == .up {//向上滚动
                if currentOffsetY >= -70 {//关闭大菜单 显示小菜单
                    showSmallMenu()
                } else { //显示大菜单 关闭小菜单
                    showBigMenu()
                }
            } else if direction == .down {
                if currentOffsetY <= -30 {//显示大菜单 关闭小菜单
                    showBigMenu()
                } else {//关闭大菜单 显示小菜单
                    showSmallMenu()
                }
            }
        } else {//一个屏幕能全部显示完
            if ccvTopMenu.alpha < 1 {
                ccvTopOffset.constant = 0
                UIView.animate(withDuration: 0.35, animations: {
                    self.ccvTopMenu.alpha = 1
                    self.setNavBarAlpha(0)
                    self.tblList.contentOffset = CGPoint(x: 0, y: -100)
                    self.topMenuContentView.layoutIfNeeded()
                }, completion: { (finished) in
                    self.setNavbarMenu(hidden: true)
                    self.startTrackingScroll = true
                })
            } else {
                self.startTrackingScroll = true
            }
        }
    }
    
    fileprivate func showSmallMenu() {
        if currentOffsetY < 0 {
            ccvTopOffset.constant = -50
            UIView.animate(withDuration: 0.35, animations: {
                self.ccvTopMenu.alpha = 0
                self.setNavBarAlpha(1.0)
                self.tblList.contentOffset = CGPoint.zero
                self.topMenuContentView.layoutIfNeeded()
            }, completion: { (_) in
                self.startTrackingScroll = true
                self.topMenuContentView.isHidden = true
            })
        } else {//已经完全关闭了
            ccvTopOffset.constant = -50
            self.topMenuContentView.isHidden = true
            self.startTrackingScroll = true
        }
    }
    
    fileprivate func showBigMenu() {
        if currentOffsetY > -100, currentOffsetY < 0 {
            ccvTopOffset.constant = 0
            UIView.animate(withDuration: 0.35, animations: {
                self.ccvTopMenu.alpha = 1
                self.setNavBarAlpha(0)
                self.tblList.contentOffset = CGPoint(x: 0, y: -100)
                self.topMenuContentView.layoutIfNeeded()
            }, completion: { (_) in
                self.startTrackingScroll = true
                self.setNavbarMenu(hidden: true)
            })
        } else { ////已经完全显示了
            ccvTopOffset.constant = 0
            self.setNavbarMenu(hidden: true)
            self.startTrackingScroll = true
        }
    }
}
