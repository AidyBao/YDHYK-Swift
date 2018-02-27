//
//  ZXURLConst.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/4/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import Foundation
import UIKit

let ZXBOUNDS_WIDTH      =   UIScreen.main.bounds.size.width
let ZXBOUNDS_HEIGHT     =   UIScreen.main.bounds.size.height

class ZX {
    
    static let PageSize:Int             =   12
    static let HUDDelay                 =   1.2
    static let CallDelay                =   0.5
    
    //MARK: - 会员、管家、店铺二维码
    static let QRCode_ContainText       =   ".120v.cn"   //二维码地址需包含
    //定位失败 默认位置
    struct Location {
        static let latitude             =   30.592061
        static let longitude            =   104.063396
    }
    
    struct Package {
        //MARK: - 应用包名
        static let enterpriseBundleId   =   "com.reson.ydhyk"           //企业
        static let appStoreBundleId     =   "com.reson.ydhyk.appstore"  //AppStore
        static let appStoreId           =   "1075692786"
    }
    //MARK: - 百度地图
    struct BMap {
        static let AppStore_Key   =   "r0IXfei1iptvnOfsZSflfGKZ"  //AppStore
        static let Enterprise_Key =   "yjd7PTElGXikZTVgHBGOE0yd"  //企业
    }
    
    //MARK: - 测试账号
    struct TestAccount {
        static let account   =   "18888888888"
        static let password  =   "666666"
    }
}


/// 接口地址
class ZXURLConst {
    //线上
    struct Api {
        static let url                  =   "https://hykinterfaceydy.120v.cn"
        static let port                 =   "443"
    }
    
    struct Resource {
        static let url                  =   "https://ydy.120v.cn"
        static let port                 =   "443"
    }
    //培训
//    struct Api {
//        static let url                  =   "https://techhykinterfaceydy.120v.cn"
//        static let port                 =   "443"
//    }
//    
//    struct Resource {
//        static let url                  =   "https://techydy.120v.cn"
//        static let port                 =   "443"
//    }
    
    struct Web {
        static let url                  =   "https://htmlydy.120v.cn/"          //Web
        static let about                =   "hyk/about/index.html?app_version=" //关于H5
        static let serviceItems         =   "hyk/licenseAgreement/index.html"   //服务条款H5
    }
    
    struct Update {
        static let enterprise           =   "https://dl.120v.cn/iOS/ydy_hyk_version.js"
        static let appstore             =   "https://itunes.apple.com/cn/lookup?id=1075692786"

    }
    
    struct Post {
        static let express              =   "https://m.kuaidi100.com/index_all.html?"
    }
}

/// 功能模块接口
class ZXAPIConst {
    //购药
    struct Store {
        static let home                 =   "siteTemplate/view"                 //店铺首页（分类、活动、推荐）
        static let storeDetail          =   "drugstore/view"                    //药店详情
        static let shoppingCart         =   "drugcounter/selectCartList"        //购物车列表
        static let markDrug             =   "member/updateCollection"           //药品收藏
        static let drugDetail           =   "drugcounter/view"                  //药品详情
        static let balance              =   "order/settleAccounts"              //结算
        static let saveOrder            =   "order/saveOrder"                   //保存订单
        static let validCoupon          =   "couponUseRecord/getCouponUseRecordList" //可用现金券
        static let recordDrug           =   "browseRecord/addOrUpdate"          //添加商品浏览记录
        static let relateDrugList       =   "drugcounter/randList"              //药品详情 推荐商品
        static let recommendDrugList    =   "browseRecord/list"                 //猜您需药
        static let searchDrug           =   "drugcounter/list"                  //分类列表、药品搜索列表
        static let activeList           =   "drugActive/list"                   //活动商品列表
        static let categoryTree         =   "drugsort/treelist"                 //分类树
    }
    
    struct FileResouce {
        static let url                  =   "hyk/pages/uploadFileApp"           //文件上传接口
        static let portraitFolder       =   "member"                            //头像存储文件夹
        static let chuFFolder           =   "prescription"                      //处方存储文件夹
        static let reportFolder         =   "laboratorySheet"                   //化验单存储文件夹
    }
    
    /// 首页-发现
    struct Discover {
        static let list                 =   "promotion/list"                    //发现列表
        static let detail               =   "promotion/view"                    //发现详情
    }
    
    /// 药店会员
    struct StoreMember {
        //读取剪贴板时,获取店铺名称,判断是否会员
        static let isOldMember          =   "memberRelation/memberValidate"
        static let join                 =   "memberRelation/addRelation"
        static let storeInfo            =   "drugstore/view"
        static let historyCoupon        =   "couponUseRecord/addMemberCoupon"   //会员关联历史现金券
        static let historyPromotion     =   "promotion/addMemberPromotion"      //会员关联历史促销信息
    }
    
    /// 现金券
    struct Coupon {
        static let list                 =   "couponUseRecord/list"
        static let detail               =   "coupon/view"
    }
    
    /// 消息
    struct Message {
        static let list                 =   "message/list"
        static let detail               =   "message/view"
    }
    
    /// 处方
    struct Prescription {
        static let list                 =   "memberPrescription/list"
        static let detail               =   "memberPrescription/view"
        static let add                  =   "memberPrescription/add"
        static let delete               =   "memberPrescription/remove"
    }
    
    
    /// 用户订单
    struct Order {
        static let list                 =   "order/list"
        static let detail               =   "order/view"
        static let update               =   "order/update"                       //订单操作 取消 删除 确认收货
        static let pickupCode           =   "order/viewCode"                    //提货码
    }
    
    /// 化验单
    struct Report {
        static let list                 =   "laboratorySheet/list"              //化验单列表
        static let detail               =   "laboratorySheet/view"              //化验单详情
        static let result               =   "laboratorySheet/viewAbnormal"      //分析结果
        static let checkItemList        =   "laboratoryItem/list"               //检查项列表
        static let add                  =   "laboratorySheet/add"               //新增化验单
        static let delete               =   "laboratorySheet/remove"            //删除化验单
    }
    
    /// 药品收藏
    struct MarkedDrug {
        static let list                 =   "memberCollection/list"
        static let delete               =   "memberCollection/delete"
    }
    
    /// 远程通知 相关操作
    struct RemoteNotice {
        static let remindLater          =   "remind/remindWait"                 //稍后提醒
        static let remindList           =   "remind/remindPush"                 //用药提醒列表
        static let voiceRemind          =   "member/updateVoiceRemind"          //更新推送用药语音提醒状态(开启语音提醒)
    }
    
    struct Common {
        static let dicList              =   "dict/getDictList"                  //常量列表
        static let unReadMsg            =   "statistics/statisticsData"         //个人中心角标统计
    }
    
    struct Pay {
        static let alipay               =   "order/createAlipay"
        static let callBack             =   "order/payOrderEnd"
    }
    
    //MARK: - User
    struct User {
        static let getSMSCode                   =   "member/SMSVerificationCode" //获取验证码URL
        static let login                        =   "member/login"               //登录URL
        static let updateEquipmentInfo          =   "member/updateEquipmentInfo" //更新设备信息URL
        static let getFlashScreen               =   "flashScreen/getFlashScreen" //获取闪屏数据
        static let updatePosition               =   "member/updatePosition"      //更新会员信息
        static let getDictList                  =   "dict/getDictList"           //获取年龄段
        static let updateSex                    =   "member/updateSex"           //更新性别
        static let updateAgeGroups              =   "member/updateAgeGroups"     //更新年龄段
    }
    
    //MARK: - 附近药店
    struct Nearby {
        static let nearbyDrugstore              =   "drugstore/list"       //附近药店
    }
    
    //MARK: - 卡.购药
    struct Card {
        static let myCard       =   "memberRelation/myCard"        //会员卡查询
        static let closestList  =   "drugstore/closestList"        //获取附近10条数据
        static let deleted      =   "memberRelation/removeMyCard"  //删除我的会员卡
    }
    
    
    //MARK: - 个人
    struct Personal {
        static let repeatedReminder     =   "member/updateRepeatedReminders"    //开启关闭重复提醒
        static let updateSex            =   "member/updateSex"                  //修改性别
        static let updateAgeGroups      =   "member/updateAgeGroups"            //修改年龄段
        static let updateHeadPortrait   =   "member/updateHeadPortrait"         //更新会员头像
        static let addressList          =   "memberAddress/getListByMemberId"   //收货地址清单
        static let removeAddress        =   "memberAddress/remove"              //移除收货地址
        static let defaultAddress       =   "memberAddress/setDefault"          //设置默认收货地址
        static let updateAddress        =   "memberAddress/update"              // 修改收货地址
        static let addAddress           =   "memberAddress/add"                 //新增收货地址
        static let updateName           =   "member/updateName"                 //修改用户名字
        static let voiceRemind          =   "member/updateVoiceRemind"          //推送用药语音提醒
        static let getAreaList          =   "area/getAreaList"                 //获取区域
    }
    
    //MARK: - 用药提醒模块
    struct UseDrug {
        static let drugRemindList     =   "remind/getListByMemberId"           //已添加提醒URL
        static let openDrugRemind     =   "remind/isOpen"                      //用药提醒药品开启/关闭提醒URL
        static let removeDrugRemind   =   "remind/remove"                      //用药提醒药品删除
        static let historyDrugOrder   =   "remind/getOrderByMemberId"          //用药提醒历史订单药品列表
        static let addRemind          =   "remind/add"                         //添加用药提醒
        static let searchByTime       =   "remind/searchByRemindTime"          //用药提醒按提醒时间分类查询URL
        static let defaultAddress     =   "memberAddress/setDefault"           //设置默认收货地址
        static let modifyRemindTime   =   "remind/updateRemindTime"            //用药提醒修改提醒时间
        static let removeMyCard       =   "memberRelation/removeMyCard"        //删除我的会员卡
    }
}
